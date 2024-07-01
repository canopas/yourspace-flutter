import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/message/server_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_models.freezed.dart';
part 'message_models.g.dart';

@freezed
class ApiThread with _$ApiThread {
  const ApiThread._();

  const factory ApiThread({
    required String id,
    required String space_id,
    required String admin_id,
    required List<String> member_ids,
    Map<String, double>? archived_for,
    int? created_at,
  }) = _ApiThread;

  factory ApiThread.fromJson(Map<String, dynamic> data) =>
      _$ApiThreadFromJson(data);

  factory ApiThread.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return ApiThread.fromJson(data!);
  }

  Map<String, dynamic> toFireStore(ApiThread space) => space.toJson();

  bool isGroup() {
    return member_ids.length > 2;
  }
}

@freezed
class ApiThreadMessage with _$ApiThreadMessage {
  const ApiThreadMessage._();

  const factory ApiThreadMessage({
    required String id,
    required String thread_id,
    required String sender_id,
    required String message,
    required List<String> seen_by,
    Map<String, double>? archived_for,
    @ServerTimestampConverter() DateTime? created_at,
  }) = _ApiThreadMessage;

  factory ApiThreadMessage.fromJson(Map<String, dynamic> json) =>
      _$ApiThreadMessageFromJson(json);

  factory ApiThreadMessage.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return ApiThreadMessage.fromJson(data!);
  }

  Map<String, dynamic> toFireStore(ApiThreadMessage message) =>
      message.toJson();

  int get createdAtMs => created_at!.millisecondsSinceEpoch;
}

@freezed
class ThreadInfo with _$ThreadInfo {
  const ThreadInfo._();

  const factory ThreadInfo({
    required ApiThread thread,
    required List<ApiThreadMessage> threadMessage,
    required List<ApiUserInfo> members,
  }) = _ThreadInfo;

  factory ThreadInfo.fromJson(Map<String, dynamic> data) =>
      _$ThreadInfoFromJson(data);

  factory ThreadInfo.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return ThreadInfo.fromJson(data!);
  }

  Map<String, dynamic> toFireStore(ThreadInfo space) => space.toJson();
}
