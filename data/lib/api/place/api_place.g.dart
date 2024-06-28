// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiPlaceImpl _$$ApiPlaceImplFromJson(Map<String, dynamic> json) =>
    _$ApiPlaceImpl(
      id: json['id'] as String,
      created_by: json['created_by'] as String,
      space_id: json['space_id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radius: (json['radius'] as num?)?.toDouble() ?? 200.0,
      created_at: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created_at'], const TimeStampJsonConverter().fromJson),
    );

Map<String, dynamic> _$$ApiPlaceImplToJson(_$ApiPlaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.created_by,
      'space_id': instance.space_id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
      'created_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.created_at, const TimeStampJsonConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$ApiPlaceMemberSettingImpl _$$ApiPlaceMemberSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiPlaceMemberSettingImpl(
      user_id: json['user_id'] as String,
      place_id: json['place_id'] as String,
      alert_enabled: json['alert_enabled'] as bool? ?? false,
      arrival_alert_for: (json['arrival_alert_for'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      leave_alert_for: (json['leave_alert_for'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ApiPlaceMemberSettingImplToJson(
        _$ApiPlaceMemberSettingImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'place_id': instance.place_id,
      'alert_enabled': instance.alert_enabled,
      'arrival_alert_for': instance.arrival_alert_for,
      'leave_alert_for': instance.leave_alert_for,
    };
