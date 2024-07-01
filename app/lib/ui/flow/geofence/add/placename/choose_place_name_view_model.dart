import 'package:data/api/auth/auth_models.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/place_service.dart';
import 'package:data/service/space_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'choose_place_name_view_model.freezed.dart';

final choosePlaceViewStateProvider = StateNotifierProvider.autoDispose<
    ChoosePlaceNameViewNotifier, ChoosePlaceViewState>((ref) {
  return ChoosePlaceNameViewNotifier(
    ref.read(currentUserPod),
    ref.read(placeServiceProvider),
    ref.read(spaceServiceProvider),
  );
});

class ChoosePlaceNameViewNotifier extends StateNotifier<ChoosePlaceViewState> {
  final ApiUser? _currentUser;
  final PlaceService placesService;
  final SpaceService spaceService;

  LatLng? _location;
  String? _spaceId;

  ChoosePlaceNameViewNotifier(
      this._currentUser, this.placesService, this.spaceService)
      : super(const ChoosePlaceViewState());

  void setData(LatLng position, String spaceId) {
    final suggestionList = [
      'Home',
      'Work',
      'School',
      'Gym',
      'Park',
      'Grocery Store',
      'Shop',
      'Cafe',
      'Restaurant'
    ];
    _location = position;
    _spaceId = spaceId;
    state = state.copyWith(suggestions: suggestionList);
  }

  void onTapAddPlaceBtn(String value) async {
    try {
      state = state.copyWith(addingPlace: true);
      final members = await spaceService.getMemberBySpaceId(_spaceId!);
      final memberIds = members.map((member) => member.id).toList();

      await placesService.addPlace(
        _spaceId!,
        value,
        _location!.latitude,
        _location!.longitude,
        _currentUser!.id,
        memberIds,
      );
      state =
          state.copyWith(popToPlaceList: DateTime.now(), addingPlace: false);
    } catch (error, stack) {
      state = state.copyWith(addingPlace: false, error: error);
      logger.e(
        'ChoosePlacesNameViewNotifier: Error while adding place',
        error: error,
        stackTrace: stack,
      );
    }
  }
}

@freezed
class ChoosePlaceViewState with _$ChoosePlaceViewState {
  const factory ChoosePlaceViewState({
    @Default(false) addingPlace,
    List<String>? suggestions,
    Object? error,
    DateTime? popToPlaceList,
  }) = _ChoosePlaceViewState;
}
