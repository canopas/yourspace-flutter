import 'package:data/api/auth/api_user_service.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/app_preferences.dart';

final authServiceProvider = Provider((ref) => AuthService(
    ref.read(currentUserPod),
    ref.read(apiUserServiceProvider),
    ref.read(currentUserJsonPod.notifier),
    ref.read(currentUserSessionJsonPod.notifier)));

class AuthService {
  final ApiUser? _currentUser;
  final ApiUserService userService;
  final StateController<String?> userJsonNotifier;
  final StateController<String?> userSessionJsonNotifier;

  AuthService(this._currentUser, this.userService, this.userJsonNotifier,
      this.userSessionJsonNotifier);

  ApiUser? get currentUser => _currentUser;

  Future<bool> verifiedLogin(
      {required String uid,
      String? firebaseToken,
      String? phone,
      String? email,
      String? firstName,
      String? lastName,
      String? profileImg,
      int authType = LOGIN_TYPE_PHONE}) async {
    final data = await userService.saveUser(
        uid: uid,
        firebaseToken: firebaseToken,
        phone: phone,
        email: email,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImg,
        authType: authType);
    userJsonNotifier.state = (data['user'] as ApiUser).toJsonString();
    userSessionJsonNotifier.state =
        (data['session'] as ApiSession).toJsonString();

    return data['isNewUser'] as bool;
  }

  Future<void> updateCurrentUser(ApiUser user) async {
    await userService.updateUser(user);
    userJsonNotifier.state = user.toJsonString();
  }

  Future<ApiUser?> getUser() {
    return userService.getUser(_currentUser?.id ?? '');
  }

  Stream<ApiUser?> getUserStream({String? currentUserId}) {
   return userService.getUserStream(currentUserId ?? _currentUser?.id ?? '');
  }

  Future<void> deleteAccount({String? currentUserId}) async {
    await userService.deleteUser(currentUserId ?? _currentUser?.id ?? '');
    userService.clearPreference();
  }
}
