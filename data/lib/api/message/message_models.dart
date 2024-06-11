import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/auth/auth_models.dart';
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
    String? message,
    required List<String> seen_by,
    Map<String, double>? archived_for,
    DateTime? created_at,
  }) = _ApiThreadMessage;

  factory ApiThreadMessage.fromJson(Map<String, dynamic> json) =>
      _$ApiThreadMessageFromJson(_convertTimestamps(json));

  factory ApiThreadMessage.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    Map<String, dynamic>? data = snapshot.data();
    return ApiThreadMessage.fromJson(data!);
  }

  Map<String, dynamic> toFireStore(ApiThreadMessage message) =>
      message.toJson();

  bool isSent() {
    return created_at != null;
  }
}

Map<String, dynamic> _convertTimestamps(Map<String, dynamic> json) {
  json.update('created_at', (value) => (value as Timestamp).toDate().toString(),
      ifAbsent: () => null);
  return json;
}

@freezed
class ThreadInfo with _$ThreadInfo {
  const ThreadInfo._();

  const factory ThreadInfo({
    required ApiThread thread,
    required List<ApiUserInfo> members,
    required List<ApiThreadMessage> threadMessage,
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
