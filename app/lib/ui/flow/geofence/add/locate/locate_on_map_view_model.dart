import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'locate_on_map_view_model.freezed.dart';

final locateOnMapViewStateProvider =
    StateNotifierProvider.autoDispose<LocateOnMapVieNotifier, LocateOnMapState>(
        (ref) {
  return LocateOnMapVieNotifier();
});

class LocateOnMapVieNotifier extends StateNotifier<LocateOnMapState> {
  LocateOnMapVieNotifier() : super(const LocateOnMapState());

  void showLocateBtn(CameraPosition position) {
    state = state.copyWith(centerPosition: position);
  }
}

@freezed
class LocateOnMapState with _$LocateOnMapState {
  const factory LocateOnMapState({
    CameraPosition? centerPosition,
  }) = _LocateOnMapState;
}
