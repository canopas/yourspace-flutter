import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/network/client.dart';
import 'package:data/api/space/space_models.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../auth/api_user_service.dart';
import '../auth/auth_models.dart';

final apiSpaceServiceProvider = StateProvider((ref) => ApiSpaceService(
      ref.read(firestoreProvider),
      ref.read(currentUserPod),
      ref.read(apiUserServiceProvider),
    ));

class ApiSpaceService {
  final FirebaseFirestore _db;
  final ApiUser? _currentUser;
  final ApiUserService userService;

  ApiSpaceService(this._db, this._currentUser, this.userService);

  CollectionReference get _spaceRef =>
      _db.collection("spaces").withConverter<ApiSpace>(
          fromFirestore: ApiSpace.fromFireStore,
          toFirestore: (space, options) => space.toJson());

  CollectionReference spaceMemberRef(String spaceId) {
    return FirebaseFirestore.instance
        .collection('spaces')
        .doc(spaceId)
        .collection('space_members');
  }

  Future<String> createSpace(String name) async {
    final doc = _spaceRef.doc();
    final adminId = _currentUser?.id ?? "";
    final space = ApiSpace(
        id: doc.id,
        admin_id: adminId,
        name: name,
        created_at: DateTime.now().millisecondsSinceEpoch);
    await doc.set(space);
    joinSpace(doc.id);
    return doc.id;
  }

  Future<ApiSpace?> getSpace(String spaceId) async {
    final docSnapshot = await _spaceRef.doc(spaceId).get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as ApiSpace;
    }
    return null;
  }

  Future<void> joinSpace(String spaceId,
      {int role = SPACE_MEMBER_ROLE_MEMBER}) async {
    final userId = _currentUser?.id ?? '';

    final member = ApiSpaceMember(
      space_id: spaceId,
      user_id: userId,
      role: role,
      location_enabled: true,
      id: const Uuid().v4(),
      created_at: DateTime.now().millisecondsSinceEpoch,
    );

    await spaceMemberRef(spaceId).doc(userId).set(member.toJson());
    await userService.addSpaceId(userId, spaceId);
  }

  Future<List<ApiSpaceMember>> getMembersBySpaceId(String spaceId) async {
    final collectionRef = FirebaseFirestore.instance
        .collection('spaces')
        .doc(spaceId)
        .collection('space_members');

    final querySnapshot = await collectionRef.get();
    return querySnapshot.docs.map((doc) {
      return ApiSpaceMember.fromJson(doc.data());
    }).toList();
  }

  Future<List<ApiSpaceMember>> getSpaceMemberByUserId(String userId) async {
    final querySnapshot = await _spaceRef.firestore
        .collectionGroup('space_members')
        .where("user_id", isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => ApiSpaceMember.fromJson(doc.data()))
        .toList();
  }

  Future<void> enableLocation(
      String spaceId, String userId, bool enable) async {
    final querySnapshot =
        await spaceMemberRef(spaceId).where("user_id", isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({"location_enabled": enable});
    }
  }

  Future<bool> isMember(String spaceId, String userId) async {
    final querySnapshot =
        await spaceMemberRef(spaceId).where("user_id", isEqualTo: userId).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> deleteMembers(String spaceId) async {
    final querySnapshot = await spaceMemberRef(spaceId).get();
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> deleteSpace(String spaceId) async {
    await deleteMembers(spaceId);
    await _spaceRef.doc(spaceId).delete();
  }

  Future<void> removeUserFromSpace(String spaceId, String userId) async {
    final querySnapshot =
        await spaceMemberRef(spaceId).where("user_id", isEqualTo: userId).get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> updateSpace(ApiSpace space) async {
    await _spaceRef.doc(space.id).set(space);
  }
}
