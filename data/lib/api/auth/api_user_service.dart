import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/network/client.dart';
import 'package:data/service/device_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/app_preferences.dart';
import 'auth_models.dart';

final apiUserServiceProvider = StateProvider((ref) => ApiUserService(
      ref.read(firestoreProvider),
      ref.read(deviceServiceProvider),
      ref.read(currentUserJsonPod.notifier),
      ref.read(currentUserSessionJsonPod.notifier),
      ref.read(currentUserSessionJsonPod.notifier),
      ref.read(isOnboardingShownPod.notifier),
    ));

class ApiUserService {
  final FirebaseFirestore _db;
  final DeviceService _device;
  final StateController<String?> userJsonNotifier;
  final StateController<String?> currentUserSpaceId;
  final StateController<String?> userSessionJsonNotifier;
  final StateController<bool?> onBoardNotifier;

  ApiUserService(
      this._db,
      this._device,
      this.userJsonNotifier,
      this.currentUserSpaceId,
      this.userSessionJsonNotifier,
      this.onBoardNotifier);

  CollectionReference get _userRef =>
      _db.collection("users").withConverter<ApiUser>(
          fromFirestore: ApiUser.fromFireStore,
          toFirestore: (user, options) => user.toJson());

  CollectionReference _sessionRef(String userId) => _userRef
      .doc(userId)
      .collection("user_sessions")
      .withConverter<ApiSession>(
          fromFirestore: ApiSession.fromFireStore,
          toFirestore: (session, _) => session.toJson());

  Future<Map<String, dynamic>> saveUser({
    String? uid,
    String? firebaseToken,
    String? phone,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImage,
    int authType = LOGIN_TYPE_PHONE,
  }) async {
    final bool isExists = await getUser(uid) != null;

    if (isExists) {
      final sessionDocRef = _sessionRef(uid!).doc();
      final ApiSession session = ApiSession(
        id: sessionDocRef.id,
        user_id: uid,
        device_id: _device.deviceId,
        device_name: await _device.deviceName,
        session_active: true,
        app_version: await _device.appVersion,
        created_at: DateTime.now().millisecondsSinceEpoch,
      );
      await deactivateOldSessions(uid);
      await sessionDocRef.set(session);
      final user = await getUser(uid);
      return {'isNewUser': false, 'user': user, 'session': session};
    } else {
      final ApiUser user = ApiUser(
        id: uid!,
        email: email ?? '',
        phone: phone ?? '',
        auth_type: authType,
        first_name: firstName ?? '',
        last_name: '',
        provider_firebase_id_token: firebaseToken ?? '',
        profile_image: '',
        created_at: DateTime.now().millisecondsSinceEpoch,
      );

      await _userRef.doc(uid).set(user);
      final sessionDocRef = _sessionRef(uid).doc();
      final ApiSession session = ApiSession(
        id: sessionDocRef.id,
        user_id: uid,
        device_id: _device.deviceId,
        device_name: await _device.deviceName,
        session_active: true,
        app_version: await _device.appVersion,
        created_at: DateTime.now().millisecondsSinceEpoch,
      );
      await sessionDocRef.set(session);
      //  await _locationService.saveLastKnownLocation(uid);
      return {'isNewUser': true, 'user': user, 'session': session};
    }
  }

  Future<ApiUser?> getUser(String? userId) async {
    if (userId == null) return null;
    var snapshot = await _userRef.doc(userId).get();
    if (snapshot.exists) {
      return snapshot.data() as ApiUser;
    }
    return null;
  }

  Stream<ApiUser?> getUserStream(String userId) {
    return _userRef.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data() as ApiUser;
      } else {
        return null;
      }
    });
  }

  Future<void> deactivateOldSessions(String userId) async {
    final querySnapshot = await _sessionRef(userId)
        .where("session_active", isEqualTo: true)
        .get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.update({"session_active": false});
    }
  }

  Future<void> updateUser(ApiUser user) async {
    await _userRef.doc(user.id).set(user);
  }

  Future<void> deleteUser(String userId) async {
    await _userRef.doc(userId).delete();
  }

  Future<void> registerFcmToken(String userId, String token) async {
    await _userRef.doc(userId).update({"fcm_token": token});
  }

  Future<void> addSpaceId(String userId, String spaceId) async {
    await _userRef.doc(userId).update({
      "space_ids": FieldValue.arrayUnion([spaceId])
    });
  }

  Future<void> updateBatteryPct(
      String userId, String sessionId, double batteryPct) async {
    await _sessionRef(userId).doc(sessionId).update({
      "battery_pct": batteryPct,
      "updated_at": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateSessionState(
      String id, String sessionId, int state) async {
    await _sessionRef(id).doc(sessionId).update({
      "user_state": state,
      "updated_at": FieldValue.serverTimestamp(),
    });
  }

  Future<ApiSession?> getUserSession(String userId) async {
    final querySnapshot = await _sessionRef(userId)
        .where("session_active", isEqualTo: true)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data() as ApiSession;
    }
    return null;
  }

  Stream<ApiSession?> getUserSessionStream(String userId) {
    return Stream.fromFuture(_sessionRef(userId)
        .where("session_active", isEqualTo: true)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as ApiSession;
      }
      return null;
    }));
  }

  Future<void> signOut() async {
    // locationManager.stopLocationTracking();
    userJsonNotifier.state = null;
    userSessionJsonNotifier.state = null;
    onBoardNotifier.state = false;
    currentUserSpaceId.state = null;
    FirebaseAuth.instance.signOut();
    // locationManager.stopService();
  }
}
