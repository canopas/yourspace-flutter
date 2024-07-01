import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/message/message_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/api_user_service.dart';
import '../auth/auth_models.dart';
import '../network/client.dart';

final apiMessageServiceProvider = Provider((ref) => ApiMessageService(
  ref.read(firestoreProvider),
  ref.read(apiUserServiceProvider),
));

class ApiMessageService {
  final FirebaseFirestore _db;
  final ApiUserService userService;

  ApiMessageService(this._db, this.userService);

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

  Future<String> createThread({required String spaceId, required String adminId, required List<String> memberIds}) async {
    final doc = _spaceThreadRef.doc();
    final threadId = doc.id;
    final thread = ApiThread(
      id: threadId,
      space_id: spaceId,
      admin_id: adminId,
      member_ids: memberIds,
      created_at: DateTime.now().millisecondsSinceEpoch,
      archived_for: {},
    );
    await doc.set(thread);
    return threadId;
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

  Stream<List<ApiThreadMessage>> getLatestMessages(String threadId, {int limit = 20}) {
    return threadMessageRef(threadId)
        .orderBy("created_at", descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ApiThreadMessage.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }

  Stream<List<ApiUserInfo>> getLatestMessagesMembers(ApiThread thread) async* {
    final List<ApiUserInfo?> memberInfoList = [];
    for (String memberId in thread.member_ids) {
      final member = await userService.getUser(memberId);
      final memberInfo = member != null ? ApiUserInfo(user: member, isLocationEnabled: member.location_enabled ?? false) : null;
      memberInfoList.add(memberInfo);
    }
    final List<ApiUserInfo> filteredMemberInfoList = memberInfoList.where((info) => info != null).cast<ApiUserInfo>().toList();

    yield filteredMemberInfoList;
  }

  Future<List<ApiThreadMessage>> getMessages(String threadId, DateTime? from, {int limit = 20}) async {
    Query query = threadMessageRef(threadId)
        .orderBy("created_at", descending: true)
        .limit(limit);

    if (from != null) {
      query = query.where('created_at', isLessThan: Timestamp.fromMillisecondsSinceEpoch(from.millisecondsSinceEpoch));
    }

    QuerySnapshot snapshot = await query.get();

    List<ApiThreadMessage> messages = snapshot.docs
        .map((doc) => ApiThreadMessage.fromFireStore(doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return messages;
  }

  ApiThreadMessage generateMessage({required String threadId, required String senderId, required String message}) {
    final doc = threadMessageRef(threadId).doc();
    return ApiThreadMessage(
      id: doc.id,
      thread_id: threadId,
      sender_id: senderId,
      message: message,
      seen_by: [senderId],
      created_at: DateTime.now(),
      archived_for: {},
    );
  }

  Future<void> sendMessage(ApiThreadMessage message) async {
    final doc = threadMessageRef(message.thread_id).doc(message.id);
    await doc.set(message.toJson());
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
        final List<ApiThreadMessage> messages = [];

        getLatestMessages(thread.id, limit: 20).listen((messageList) {
          messages.addAll(messageList);
        });

        final List<ApiUserInfo?> memberInfoList = [];
        for (String memberId in thread.member_ids) {
          final user = await userService.getUser(memberId);
          final memberInfo = user != null ? ApiUserInfo(user: user, isLocationEnabled: user.location_enabled ?? false) : null;
          memberInfoList.add(memberInfo);
        }

        final List<ApiUserInfo> filteredMemberInfoList = memberInfoList.where((info) => info != null).cast<ApiUserInfo>().toList();

        return ThreadInfo(
          thread: thread,
          threadMessage: messages,
          members: filteredMemberInfoList,
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