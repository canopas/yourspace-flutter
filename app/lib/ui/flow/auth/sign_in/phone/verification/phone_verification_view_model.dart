import 'dart:async';

import 'package:data/api/auth/auth_models.dart';
import 'package:data/log/logger.dart';
import 'package:data/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_verification_view_model.freezed.dart';

final phoneVerificationStateProvider = StateNotifierProvider.autoDispose<
    PhoneVerificationViewNotifier, PhoneVerificationState>((ref) {
  return PhoneVerificationViewNotifier(
    ref.read(authServiceProvider),
    FirebaseAuth.instance,
  );
});

class PhoneVerificationViewNotifier
    extends StateNotifier<PhoneVerificationState> {
  final AuthService authService;

  final FirebaseAuth firebaseAuth;
  late String phoneNumer;
  bool firstAutoVerificationComplete = false;
  late Timer timer;

  PhoneVerificationViewNotifier(this.authService, this.firebaseAuth)
      : super(const PhoneVerificationState()) {
    updateResendCodeTimerDuration();
  }

  void updateResendCodeTimerDuration() {
    state = state.copyWith(activeResendDuration: const Duration(seconds: 30));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        activeResendDuration:
            Duration(seconds: state.activeResendDuration.inSeconds - 1),
      );
      if (state.activeResendDuration.inSeconds < 1) {
        timer.cancel();
      }
    });
  }

  void updatePhoneAndVerificationId(
      {required String phone, required String verificationId}) {
    state = state.copyWith(verificationId: verificationId);
    phoneNumer = phone;
  }

  void updateOTP(String otp) {
    state = state.copyWith(
      otp: otp,
      enableVerify: otp.length == 6,
    );

    if (!firstAutoVerificationComplete && otp.length == 6) {
      firstAutoVerificationComplete = true;
      // verifyPhone();
    }
  }

  Future<void> resendOtp({required String phone}) async {
    state = state.copyWith(error: null);
    updateResendCodeTimerDuration();
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (authCredential) async {
          final userCredential =
              await firebaseAuth.signInWithCredential(authCredential);
          final firebaseIdToken = await userCredential.user?.getIdToken() ?? '';
          final isNewUser = await authService.verifiedLogin(
            uid: userCredential.user?.uid ?? '',
            firebaseToken: firebaseIdToken,
            phone: phone,
            authType: LOGIN_TYPE_PHONE,
          );
          state = state.copyWith(
            verifying: false,
            verificationSucceed: true,
            isNewUser: isNewUser,
          );
        },
        verificationFailed: (error) {
          state = state.copyWith(error: error);
        },
        codeSent: (verificationId, resendToken) {
          state = state.copyWith(verificationId: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<void> verifyOtp() async {
    if (state.verificationId == null) return;
    state = state.copyWith(verifying: true, error: null);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: state.otp!,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final firebaseIdToken = await userCredential.user?.getIdToken() ?? '';
      final isNewUser = await authService.verifiedLogin(
        uid: userCredential.user?.uid ?? '',
        firebaseToken: firebaseIdToken,
        phone: phoneNumer,
        authType: LOGIN_TYPE_PHONE,
      );
      state = state.copyWith(
        verifying: false,
        verificationSucceed: true,
        isNewUser: isNewUser,
      );
    } catch (error, stackTrace) {
      logger.e(
        'PhoneVerificationViewNotifier: error while verify otp',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(verifying: false, error: error);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

@freezed
class PhoneVerificationState with _$PhoneVerificationState {
  const factory PhoneVerificationState({
    @Default(false) bool verifying,
    @Default(false) bool verificationSucceed,
    @Default(false) bool enableVerify,
    @Default(false) bool isNewUser,
    String? verificationId,
    @Default('') String? otp,
    Object? error,
    @Default(Duration(seconds: 30)) Duration activeResendDuration,
  }) = _PhoneVerificationState;
}
