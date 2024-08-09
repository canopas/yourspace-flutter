import 'dart:io';

import 'package:data/api/auth/auth_models.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/auth_service.dart';
import 'package:data/service/location_manager.dart';
import 'package:data/service/space_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_view_model.freezed.dart';

final editProfileViewStateProvider = StateNotifierProvider.autoDispose<
    EditProfileViewNotifier, EditProfileViewState>(
  (ref) => EditProfileViewNotifier(
    ref.read(spaceServiceProvider),
    ref.read(authServiceProvider),
    ref.read(currentUserPod),
    ref.read(locationManagerProvider),
  ),
);

class EditProfileViewNotifier extends StateNotifier<EditProfileViewState> {
  final SpaceService spaceService;
  final AuthService authService;
  final ApiUser? user;
  final LocationManager locationManager;

  EditProfileViewNotifier(
    this.spaceService,
    this.authService,
    this.user,
    this.locationManager,
  ) : super(EditProfileViewState(
          firstName: TextEditingController(text: user?.first_name),
          lastName: TextEditingController(text: user?.last_name),
          email: TextEditingController(text: user?.email),
          phone: TextEditingController(text: user?.phone),
          enableEmail: user?.auth_type == LOGIN_TYPE_PHONE,
          enablePhone: user?.auth_type == LOGIN_TYPE_GOOGLE,
          profileUrl: user?.profile_image ?? '',
        ));

  void deleteAccount() async {
    try {
      state = state.copyWith(deletingAccount: true);
      await spaceService.deleteUserSpaces();
      await authService.deleteAccount(currentUserId: user?.id);
      state = state.copyWith(deletingAccount: false, accountDeleted: true, error: null);
      locationManager.stopTrackingService();
    } catch (error, stack) {
      logger.e(
        'EditProfileViewState: error while delete account',
        error: error,
        stackTrace: stack,
      );
      state = state.copyWith(error: error);
    }
  }

  void save() {
    try {
      final newUser = user!.copyWith(
        first_name: state.firstName.text.trim(),
        last_name: state.lastName.text.trim(),
        email: state.email.text.trim(),
        phone: state.phone.text.trim(),
        profile_image: state.profileUrl,
      );
      state = state.copyWith(saving: true);
      authService.updateCurrentUser(newUser);
      state = state.copyWith(saving: false, saved: true, error: null);
    } catch (error, stack) {
      logger.e(
        'EditProfileViewNotifier: error while update user profile',
        error: error,
        stackTrace: stack,
      );
      state = state.copyWith(error: error);
    }
  }

  void onChange() {
    final validFirstName = state.firstName.text.trim().length >= 3;
    final validEmail = state.email.text.trim().length >= 3;
    final validPhone = state.phone.text.trim().length >= 3;

    final isValid = validFirstName && (validEmail || validPhone);
    final changed = state.firstName.text.trim() != user?.first_name ||
        state.lastName.text.trim() != user?.last_name ||
        state.email.text.trim() != user?.email ||
        state.phone.text.trim() != user?.phone ||
        state.profileUrl != user?.profile_image;

    state = state.copyWith(allowSave: isValid && changed);
  }

  void uploadProfileImage(String uri) async {
    try {
      final storage = FirebaseStorage.instance;
      final fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final userId = user?.id ?? '';
      final imageRef = storage.ref().child('profile_images/$userId/$fileName');

      final uploadTask = imageRef.putFile(File(uri));

      uploadTask.snapshotEvents.listen((event) {
        state = state.copyWith(uploadingImage: true);
      });

      await uploadTask;

      final downloadUrl = await imageRef.getDownloadURL();
      state = state.copyWith(profileUrl: downloadUrl, uploadingImage: false);
      onChange();
    } catch (error, stack) {
      logger.e(
        'EditProfileViewNotifier: error while uploading profile image',
        error: error,
        stackTrace: stack,
      );
      state =
          state.copyWith(profileUrl: '', uploadingImage: false, error: error);
      onChange();
    }
  }

  void onRemoveImage() {
    state = state.copyWith(profileUrl: '', allowSave: true);
    onChange();
  }
}

@freezed
class EditProfileViewState with _$EditProfileViewState {
  const factory EditProfileViewState({
    @Default(false) bool saving,
    @Default(false) bool saved,
    @Default(false) bool allowSave,
    @Default(false) bool enablePhone,
    @Default(false) bool enableEmail,
    @Default(false) bool accountDeleted,
    @Default(false) bool uploadingImage,
    @Default(false) bool deletingAccount,
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
    required TextEditingController phone,
    required String profileUrl,
    Object? error,
  }) = _EditProfileViewState;
}
