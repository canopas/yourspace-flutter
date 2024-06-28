import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/place/api_place.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/place_service.dart';
import 'package:data/service/space_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yourspace_flutter/domain/extenstions/lat_lng_extenstion.dart';

part 'edit_place_view_model.freezed.dart';

final editPlaceViewStateProvider =
    StateNotifierProvider.autoDispose<EditPlaceViewNotifier, EditPlaceState>(
        (ref) {
  return EditPlaceViewNotifier(
    ref.read(currentUserPod),
    ref.read(placeServiceProvider),
    ref.read(spaceServiceProvider),
  );
});

class EditPlaceViewNotifier extends StateNotifier<EditPlaceState> {
  final ApiUser? _currentUser;
  final PlaceService placeService;
  final SpaceService spaceService;

  ApiPlace? _place;
  ApiPlaceMemberSetting? _setting;

  EditPlaceViewNotifier(this._currentUser, this.placeService, this.spaceService)
      : super(const EditPlaceState());

  void loadDate(ApiPlace place) async {
    if (state.loading) return;
    try {
      state = state.copyWith(loading: true);

      final spaceInfo = await spaceService.getSpaceInfo(place.space_id);
      final setting = await placeService.getPlaceMemberSetting(
          place.id, place.space_id, _currentUser!.id);

      final membersInfo = spaceInfo?.members
          .where((member) => member.user.id != _currentUser.id)
          .toList();
      _place = place;
      _setting = setting;
      state = state.copyWith(
        updatedPlace: place,
        membersInfo: membersInfo ?? [],
        updatedSetting: setting,
        isAdmin: place.created_by == _currentUser.id,
        loading: false,
      );
      getAddress(place.latitude, place.longitude);
    } catch (error, stack) {
      state = state.copyWith(loading: false, error: error);
      logger.e(
        'EditPlaceViewNotifier: Error while getting place setting',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void getAddress(double latitude, double longitude) async {
    if (state.gettingAddress) return;

    state = state.copyWith(gettingAddress: true);
    final latLng = LatLng(latitude, longitude);
    final address = await latLng.getAddressFromLocation();
    state = state.copyWith(address: address, gettingAddress: false);
  }

  void onMapCameraMove(CameraPosition position) {
    if (state.updatedPlace == null) return;

    final target = position.target;
    final updatePlace = state.updatedPlace
        ?.copyWith(latitude: target.latitude, longitude: target.longitude);

    state = state.copyWith(updatedPlace: updatePlace);
    getAddress(target.latitude, target.longitude);
    enableSaveBtn();
  }

  void onToggleArrives(String userId, bool arrives) {
    final arrivesList =
        List<String>.from(state.updatedSetting?.arrival_alert_for ?? []);
    if (arrivesList.isNotEmpty) {
      if (arrives) {
        arrivesList.add(userId);
      } else {
        arrivesList.remove(userId);
      }
      final updatedSettings =
          state.updatedSetting?.copyWith(arrival_alert_for: arrivesList);
      state = state.copyWith(updatedSetting: updatedSettings);
    }
    enableSaveBtn();
  }

  void onPlaceNameChanged(String value) {
    final updatedPlace = state.updatedPlace?.copyWith(name: value);
    state = state.copyWith(updatedPlace: updatedPlace);
  }

  void onToggleLeaves(String userId, bool leaves) {
    final leaveList =
        List<String>.from(state.updatedSetting?.leave_alert_for ?? []);
    if (leaveList.isNotEmpty) {
      if (leaves) {
        leaveList.add(userId);
      } else {
        leaveList.remove(userId);
      }
      final updatedSettings =
          state.updatedSetting?.copyWith(leave_alert_for: leaveList);
      state = state.copyWith(updatedSetting: updatedSettings);
    }
  }

  void onPlaceRadiusChanged(double value) {
    if (state.updatedPlace == null) return;
    final updatePlace = state.updatedPlace?.copyWith(radius: value);
    state = state.copyWith(updatedPlace: updatePlace,radius: value);
    enableSaveBtn();
  }

  void enableSaveBtn() {
    final isChanged = state.updatedPlace != _place ||
        (_setting != null && state.updatedSetting != _setting);
    state = state.copyWith(enableSave: isChanged);
  }

  void onSavePlace() async {
    if (state.saving &&
        state.updatedSetting == null &&
        state.updatedPlace == null) return;

    try {
      state = state.copyWith(saving: true, error: null);
      final updatedPlace = state.updatedPlace!;
      final updatedSetting = state.updatedSetting!;
      if (updatedPlace != _place) {
        await placeService.updatePlace(updatedPlace);
      }
      if (updatedSetting != _setting) {
        await placeService.updatePlaceSetting(
          updatedPlace.space_id,
          updatedPlace.id,
          _currentUser!.id,
          updatedSetting,
        );
      }
      state = state.copyWith(saving: false, popToBack: DateTime.now());
    } catch (error, stack) {
      state = state.copyWith(saving: false, error: error);
      logger.e(
        'EditPlaceViewNotifier: Error while saving place',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void onTapDeletePlaceBtn() {
    state = state.copyWith(showDeleteDialog: DateTime.now());
  }

  void onPlaceDelete() async {
    if (_place == null) return;
    try {
      state = state.copyWith(deleting: true, error: null);
      await placeService.deletePlace(_place!.space_id, _place!.id);
      state = state.copyWith(deleting: false, popToBack: DateTime.now());
    } catch (error, stack) {
      state = state.copyWith(error: error, deleting: false);
      logger.e(
        "EditPlaceViewNotifier: Error while deleting place",
        error: error,
        stackTrace: stack,
      );
    }
  }
}

@freezed
class EditPlaceState with _$EditPlaceState {
  const factory EditPlaceState({
    @Default(false) bool loading,
    @Default(false) bool isAdmin,
    @Default(false) bool enableSave,
    @Default(false) bool saving,
    @Default(false) bool deleting,
    @Default(false) bool gettingAddress,
    String? placeId,
    ApiPlace? updatedPlace,
    ApiPlaceMemberSetting? updatedSetting,
    @Default([]) List<ApiUserInfo> membersInfo,
    String? address,
    double? radius,
    Object? error,
    DateTime? popToBack,
    DateTime? showDeleteDialog,
  }) = _EditPlaceState;
}
