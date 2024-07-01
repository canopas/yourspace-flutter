import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/place/api_place.dart';
import 'package:data/log/logger.dart';
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

import 'map_view.dart';

part 'map_view_model.freezed.dart';

final mapViewStateProvider =
    StateNotifierProvider.autoDispose<MapViewNotifier, MapViewState>((ref) {
  return MapViewNotifier(
    ref.read(currentUserPod),
    ref.read(spaceServiceProvider),
    ref.read(placeServiceProvider),
    ref.read(permissionServiceProvider),
  );
});

class MapViewNotifier extends StateNotifier<MapViewState> {
  final ApiUser? _currentUser;
  final SpaceService spaceService;
  final PlaceService placeService;
  final PermissionService permissionService;

  MapViewNotifier(
    this._currentUser,
    this.spaceService,
    this.placeService,
    this.permissionService,
  ) : super(const MapViewState());

  void loadData(String? spaceId) {
    onSelectedSpaceChange();

    if (spaceId == null) return;

    listenMemberLocation(spaceId);
    listenPlaces(spaceId);
  }

  void onSelectedSpaceChange() {
    state = state.copyWith(
      userInfo: [],
      places: [],
      markers: [],
      defaultPosition: null,
      selectedUser: null,
    );
  }

  void listenMemberLocation(String spaceId) async {
    if (state.loading) return;
    try {
      state = state.copyWith(loading: true, selectedUser: null);
      spaceService.getMemberWithLocation(spaceId).listen((userInfo) {
        state = state.copyWith(userInfo: userInfo, loading: false);
        userMapPositions(userInfo);
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

  void listenPlaces(String spaceId) async {
    try {
      placeService.getAllPlacesStream(spaceId).listen((places) {
        state = state.copyWith(places: places);
      });
    } catch (error, stack) {
      logger.e(
        'MapViewNotifier: Error while getting places',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void userMapPositions(List<ApiUserInfo> userInfo) async {
    final List<UserMarker> markers = [];
    for (final info in userInfo) {
      if (info.user.id == _currentUser?.id) {
        mapCameraPosition(info);
      }

      if (info.location != null) {
        markers.add(UserMarker(
          userId: info.user.id,
          userName: info.user.fullName,
          imageUrl: await _convertUrlToImage(info.user.profile_image),
          latitude: info.location!.latitude,
          longitude: info.location!.longitude,
          isSelected: false,
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

  void mapCameraPosition(ApiUserInfo userInfo) {
    final position = CameraPosition(
      target: LatLng(userInfo.location?.latitude ?? 0.0,
          userInfo.location?.longitude ?? 0.0),
      zoom: defaultCameraZoom,
    );
    state = state.copyWith(defaultPosition: position);
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
    onShowDetailUpdateUserMarker(null);
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
    onShowDetailUpdateUserMarker(member.user.id);
  }

  void onShowDetailUpdateUserMarker(String? userId) {
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

  void checkLocationAndNotificationPermission() async {
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
