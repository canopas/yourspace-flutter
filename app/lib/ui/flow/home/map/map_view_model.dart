import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/place/api_place.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/location_manager.dart';
import 'package:data/service/permission_service.dart';
import 'package:data/service/place_service.dart';
import 'package:data/service/space_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;

import 'map_screen.dart';

part 'map_view_model.freezed.dart';

final mapViewStateProvider =
    StateNotifierProvider.autoDispose<MapViewNotifier, MapViewState>((ref) {
  return MapViewNotifier(
    ref.read(currentUserPod),
    ref.read(spaceServiceProvider),
    ref.read(placeServiceProvider),
    ref.read(permissionServiceProvider),
    ref.read(locationManagerProvider),
  );
});

class MapViewNotifier extends StateNotifier<MapViewState> {
  final ApiUser? _currentUser;
  final SpaceService spaceService;
  final PlaceService placeService;
  final PermissionService permissionService;
  final LocationManager locationManager;

  MapViewNotifier(
    this._currentUser,
    this.spaceService,
    this.placeService,
    this.permissionService,
    this.locationManager,
  ) : super(const MapViewState());

  void loadData(String? spaceId) {
    _onSelectedSpaceChange();

    if (spaceId == null) return;

    _listenMemberLocation(spaceId);
    _listenPlaces(spaceId);
  }

  void _onSelectedSpaceChange() {
    state = state.copyWith(
      userInfo: [],
      places: [],
      markers: [],
      defaultPosition: null,
      selectedUser: null,
    );
  }

  void _listenMemberLocation(String spaceId) async {
    if (state.loading) return;
    try {
      state = state.copyWith(loading: true, selectedUser: null);
      spaceService.getMemberWithLocation(spaceId).listen((userInfo) {
        state = state.copyWith(userInfo: userInfo, loading: false);
        _userMapPositions(userInfo);
      });
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'MapViewNotifier: Error while getting members location',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _listenPlaces(String spaceId) async {
    try {
      placeService.getAllPlacesStream(spaceId).listen((places) {
        state = state.copyWith(places: places);
      });
    } catch (error, stack) {
      state = state.copyWith(error: error);
      logger.e(
        'MapViewNotifier: Error while getting places',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _userMapPositions(List<ApiUserInfo> userInfo) async {
    final List<UserMarker> markers = [];
    for (final info in userInfo) {
      if (info.user.id == _currentUser?.id && state.defaultPosition == null) {
        final latLng = LatLng(
          info.location?.latitude ?? 0.0,
          info.location?.longitude ?? 0.0,
        );
        _mapCameraPosition(latLng, defaultCameraZoom);
      }

      if (info.location != null && info.isLocationEnabled) {
        markers.add(UserMarker(
          userId: info.user.id,
          userName: info.user.fullName,
          imageUrl: await _convertUrlToImage(info.user.profile_image),
          latitude: info.location!.latitude,
          longitude: info.location!.longitude,
          isSelected: state.selectedUser == null
              ? false
              : state.selectedUser?.user.id == info.user.id,
        ));
      }
    }

    state = state.copyWith(markers: markers);
  }

  Future<ui.Image?> _convertUrlToImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return null;

    try {
      final cacheManager = DefaultCacheManager();
      final file = await cacheManager.getSingleFile(imageUrl);

      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image != null) {
        final resizedImage = img.copyResize(
          image,
          width: placeSize.toInt(),
          height: placeSize.toInt(),
        );
        final circularImage = img.copyCropCircle(resizedImage);

        final byteData = ByteData.view(
          Uint8List.fromList(img.encodePng(circularImage)).buffer,
        );

        final codec =
            await ui.instantiateImageCodec(byteData.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        return frame.image;
      }
    } catch (e) {
      debugPrint("Error while getting network image: $e");
    }
    return null;
  }

  void onAddMemberTap(String spaceId) async {
    try {
      state = state.copyWith(fetchingInviteCode: true, spaceInvitationCode: '');
      final code = await spaceService.getInviteCode(spaceId);
      state = state.copyWith(
          spaceInvitationCode: code ?? '', fetchingInviteCode: false);
    } catch (error, stack) {
      state = state.copyWith(error: error, fetchingInviteCode: false);
      logger.e(
        'MapViewNotifier: Error while getting invitation code',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void onDismissMemberDetail() {
    state = state.copyWith(selectedUser: null, defaultPosition: null);
    _onSelectUserMarker(null);
  }

  void showMemberDetail(ApiUserInfo member) {
    final selectedMember =
        (state.selectedUser?.user.id == member.user.id) ? null : member;
    final position = (selectedMember != null && selectedMember.location != null)
        ? CameraPosition(
            target: LatLng(selectedMember.location!.latitude,
                selectedMember.location!.longitude),
            zoom: defaultCameraZoomForSelectedUser)
        : null;

    state =
        state.copyWith(selectedUser: selectedMember, defaultPosition: position);
    _onSelectUserMarker(member.user.id);
  }

  void _onSelectUserMarker(String? userId) {
    final List<UserMarker> updatedMarkers;

    if (userId == null) {
      updatedMarkers = state.markers
          .map((marker) => marker.copyWith(isSelected: false))
          .toList();
    } else {
      updatedMarkers = state.markers.map((marker) {
        return marker.userId == userId
            ? marker.copyWith(isSelected: !marker.isSelected)
            : marker.copyWith(isSelected: false);
      }).toList();
    }
    state = state.copyWith(markers: updatedMarkers);
  }

  void onTapUserMarker(String userId) {
    final user = state.userInfo.firstWhere((user) => user.user.id == userId);
    showMemberDetail(user);
  }

  void checkUserPermission() async {
    final isLocationEnabled = await permissionService.isLocationAlwaysEnabled();
    final isLocationServiceEnabled =
        await permissionService.isLocationServiceEnabled();
    final isNotificationEnabled =
        await permissionService.hasNotificationPermission();
    final isFineLocationPermission =
        await permissionService.isLocationPermissionGranted();

    state = state.copyWith(
      hasLocationEnabled: isLocationEnabled,
      hasLocationServiceEnabled: isLocationServiceEnabled,
      hasNotificationEnabled: isNotificationEnabled,
      hasFineLocationEnabled: isFineLocationPermission,
    );
  }

  void showEnableLocationDialog() {
    state = state.copyWith(showLocationDialog: DateTime.now());
  }

  void getUserLastLocation() async {
    try {
      state = state.copyWith(defaultPosition: null);
      final isEnabled = await permissionService.isLocationPermissionGranted();
      if (isEnabled) {
        final position = await locationManager.getLastLocation();
        final latLng = LatLng(position!.latitude, position.longitude);
        _mapCameraPosition(latLng, defaultCameraZoom);
      } else {
        for (final info in state.userInfo) {
          if (info.user.id == _currentUser?.id) {
            final latLng = LatLng(
              info.location?.latitude ?? 0.0,
              info.location?.longitude ?? 0.0,
            );
            _mapCameraPosition(latLng, defaultCameraZoom);
          }
        }
      }
    } catch (error, stack) {
      state = state.copyWith(error: error);
      logger.e(
        'MapViewNotifier: Error while getting last location',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _mapCameraPosition(LatLng latLng, double zoom) {
    final cameraPosition = CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: zoom,
    );
    state = state.copyWith(defaultPosition: cameraPosition);
  }
}

@freezed
class MapViewState with _$MapViewState {
  const factory MapViewState({
    @Default(false) loading,
    @Default(false) bool fetchingInviteCode,
    @Default(false) bool hasLocationEnabled,
    @Default(false) bool hasLocationServiceEnabled,
    @Default(false) bool hasNotificationEnabled,
    @Default(false) bool hasFineLocationEnabled,
    @Default([]) List<ApiUserInfo> userInfo,
    @Default([]) List<ApiPlace> places,
    @Default([]) List<UserMarker> markers,
    ApiUserInfo? selectedUser,
    CameraPosition? defaultPosition,
    @Default('') String spaceInvitationCode,
    Object? error,
    DateTime? showLocationDialog,
  }) = _MapViewState;
}

@freezed
class UserMarker with _$UserMarker {
  const factory UserMarker({
    required String userId,
    required String userName,
    required ui.Image? imageUrl,
    required double latitude,
    required double longitude,
    required bool isSelected,
  }) = _UserMarker;
}
