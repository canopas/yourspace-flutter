import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/time_converter.dart';

part 'api_place.freezed.dart';
part 'api_place.g.dart';

@freezed
class ApiPlace with _$ApiPlace {
  const ApiPlace._();

  const factory ApiPlace({
    required String id,
    required String created_by,
    required String space_id,
    required String name,
    required double latitude,
    required double longitude,
    @Default(200.0) double radius,
    @TimeStampJsonConverter() DateTime? created_at,
  }) = _ApiPlace;

  factory ApiPlace.fromJson(Map<String, dynamic> data) =>
      _$ApiPlaceFromJson(data);

  factory ApiPlace.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return ApiPlace.fromJson(data!);
  }

  Map<String, dynamic> toFireStore(ApiPlace space) => space.toJson();
}

@freezed
class ApiPlaceMemberSetting with _$ApiPlaceMemberSetting {
  const ApiPlaceMemberSetting._();

  const factory ApiPlaceMemberSetting({
    required String user_id,
    required String place_id,
    required bool alert_enabled,
    required List<String> arrival_alert_for,
    required List<String> leave_alert_for,
  }) = _ApiPlaceMemberSetting;

  factory ApiPlaceMemberSetting.fromJson(Map<String, dynamic> data) =>
      _$ApiPlaceMemberSettingFromJson(data);

  factory ApiPlaceMemberSetting.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return ApiPlaceMemberSetting.fromJson(data!);
  }

  Map<String, dynamic> toFireStore(ApiPlaceMemberSetting space) =>
      space.toJson();
}

@freezed
class ApiNearbyPlace with _$ApiNearbyPlace {
  const ApiNearbyPlace._();

  const factory ApiNearbyPlace({
    required String id,
    required String name,
    required String formatted_address,
    required double lat,
    required double lng,
  }) = _ApiNearbyPlace;

  factory ApiNearbyPlace.fromJson(Map<String, dynamic> data) =>
      _$ApiNearbyPlaceFromJson(data);
}
