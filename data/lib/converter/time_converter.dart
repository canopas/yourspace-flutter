import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimeStampJsonConverter extends JsonConverter<DateTime, Timestamp> {
  const TimeStampJsonConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}
