import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/message/message_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/auth/api_user_service.dart';
import '../api/auth/auth_models.dart';
import '../api/network/client.dart';

final messageServiceProvider = Provider((ref) => MessageService(
  ref.read(firestoreProvider),
  ref.read(apiUserServiceProvider),
));

class MessageService {
  final FirebaseFirestore _db;
  final ApiUserService userService;

  MessageService(this._db, this.userService);

  CollectionReference<ApiThread> get _spaceThreadRef =>
      _db.collection("space_threads").withConverter<ApiThread>(
        fromFirestore: (snapshot, _) => ApiThread.fromFireStore(snapshot, null),
        toFirestore: (thread, _) => thread.toJson(),
      );

  CollectionReference threadMessageRef(String threadId) {
    return FirebaseFirestore.instance
        .collection('space_threads')
        .doc(threadId)
        .collection('thread_messages');
  }

  Future<String> createThread({required String spaceId, required String adminId}) async {
    final doc = _spaceThreadRef.doc();
    final threadId = doc.id;
    final thread = ApiThread(
      id: threadId,
      space_id: spaceId,
      admin_id: adminId,
      member_ids: [adminId],
      created_at: DateTime.now().millisecondsSinceEpoch,
    );
    await doc.set(thread);
    return threadId;
  }

  Future<void> joinThread(String threadId, List<String> userIds) async {
    final doc = _spaceThreadRef.doc(threadId);
    await doc.update({
      "member_ids": FieldValue.arrayUnion(userIds),
    });
  }

  Stream<ApiThread> getThread(String threadId) {
    final doc = _spaceThreadRef.doc(threadId);
    return doc.snapshots().map((snapshot) => snapshot.data()!);
  }

  Stream<List<ApiThread>> getThreads(String spaceId, String userId) {
    return _spaceThreadRef
        .where("space_id", isEqualTo: spaceId)
        .where("member_ids", arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<ApiThreadMessage>> getLatestMessages(String threadId, int limit) {
    return threadMessageRef(threadId)
        .orderBy("created_at", descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ApiThreadMessage.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }

  // Future<List<ApiThreadMessage>> getMessages(String threadId, DateTime? from, {int limit = 20}) async {
  //   Query<ApiThreadMessage> query = threadMessageRef(threadId)
  //       .orderBy("created_at", descending: true)
  //       .limit(limit);
  //
  //   if (from != null) {
  //     query = query.where("created_at", isLessThan: from.millisecondsSinceEpoch);
  //   }
  //
  //   final snapshot = await query.get();
  //   return snapshot.docs.map((doc) => doc.data()).toList();
  // }

  Future<void> sendMessage(String threadId, String senderId, String message) async {
    final doc = threadMessageRef(threadId).doc();
    final threadMessage = ApiThreadMessage(
      id: doc.id,
      thread_id: threadId,
      sender_id: senderId,
      message: message,
      seen_by: [senderId],
      created_at: DateTime.now(),
    );
    await doc.set(threadMessage);
  }

  ApiThreadMessage generateMessage(String threadId, String senderId, String message) {
    final doc = threadMessageRef(threadId).doc();
    return ApiThreadMessage(
      id: doc.id,
      thread_id: threadId,
      sender_id: senderId,
      message: message,
      seen_by: [senderId],
      created_at: DateTime.now(),
    );
  }

  Future<void> sendMessageWithMessage(ApiThreadMessage message) async {
    final doc = threadMessageRef(message.thread_id).doc(message.id);
    await doc.set(message);
  }

  Future<void> markMessagesAsSeen(String threadId, List<String> messageIds, String userId) async {
    final batch = _db.batch();
    for (final id in messageIds) {
      final doc = threadMessageRef(threadId).doc(id);
      batch.update(doc, {
        "seen_by": FieldValue.arrayUnion([userId]),
      });
    }
    await batch.commit();
  }

  Stream<List<ThreadInfo>> getThreadsWithLatestMessage(String spaceId, String userId) {
    return getThreads(spaceId, userId).asyncExpand((threads) {
      if (threads.isEmpty) return Stream.value([]);

      final futures = threads.map((thread) async {
        final latestMessageSnapshot = await threadMessageRef(thread.id)
            .orderBy("created_at", descending: true)
            .limit(20)
            .get();

        final latestMessages = latestMessageSnapshot.docs
            .map((doc) => ApiThreadMessage.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        final List<ApiUserInfo?> memberInfoList = [];
        for (String memberId in thread.member_ids) {
          final user = await userService.getUser(memberId);
          final memberInfo = user != null ? ApiUserInfo(user: user, isLocationEnabled: user.location_enabled ?? false) : null;
          memberInfoList.add(memberInfo);
        }
        final List<ApiUserInfo> filteredMemberInfoList = memberInfoList.where((info) => info != null).cast<ApiUserInfo>().toList();
        return ThreadInfo(
          thread: thread,
          members: filteredMemberInfoList,
          threadMessage: latestMessages,
        );
      }).toList();

      return Stream.fromFuture(Future.wait(futures));
    });
  }

  Future<void> deleteThread(ApiThread thread, String userId) async {
    final doc = _spaceThreadRef.doc(thread.id);
    final archivedThread = Map<String, double>.from(thread.archived_for ?? {});

    if (thread.admin_id == userId) {
      await doc.delete();
    } else {
      archivedThread[userId] = DateTime.now().millisecondsSinceEpoch.toDouble();
      await doc.update({'archived_for': archivedThread});
    }
  }
}
