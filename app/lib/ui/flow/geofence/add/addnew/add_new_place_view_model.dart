import 'dart:async';

import 'package:data/api/place/api_place.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/place_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_new_place_view_model.freezed.dart';

final addNewPlaceStateProvider = StateNotifierProvider.autoDispose<
    AddNewPlaceViewNotifier, AddNewPlaceState>((ref) {
  return AddNewPlaceViewNotifier(ref.read(placeServiceProvider));
});

class AddNewPlaceViewNotifier extends StateNotifier<AddNewPlaceState> {
  final PlaceService placeService;

  AddNewPlaceViewNotifier(this.placeService) : super(const AddNewPlaceState());

  Timer? _debounce;

  void onPlaceNameChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      fidePlace(value);
    });
  }

  void fidePlace(String value) async {
    try {
      state = state.copyWith(loading: true);
      final places = await placeService.searchNearbyPlaces(
        value,
        '', // put user latitude coordinates here.
        '', // put user longitude coordinates here.
      );

      state = state.copyWith(places: places, loading: false);
    } catch (error, stack) {
      state = state.copyWith(error: error, loading: false);
      logger.e(
        'AddNewPlaceViewNotifier: Error while finding place',
        error: error,
        stackTrace: stack,
      );
    }
  }
}

@freezed
class AddNewPlaceState with _$AddNewPlaceState {
  const factory AddNewPlaceState({
    @Default(false) loading,
    @Default([]) List<ApiNearbyPlace> places,
    Object? error,
  }) = _AddNewPlaceState;
}
