import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:data/api/auth/auth_models.dart';
import 'package:data/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_with_phone_view_model.freezed.dart';

final signInWithPhoneStateProvider = StateNotifierProvider.autoDispose<
    SignInWithPhoneViewNotifier, SignInWithPhoneState>((ref) {
  return SignInWithPhoneViewNotifier(
    ref.read(authServiceProvider),
    FirebaseAuth.instance,
  );
});

class SignInWithPhoneViewNotifier extends StateNotifier<SignInWithPhoneState> {
  final AuthService authService;
  final FirebaseAuth firebaseAuth;

  SignInWithPhoneViewNotifier(this.authService, this.firebaseAuth)
      : super(
          SignInWithPhoneState(
            code: CountryCode.getCountryCodeByAlpha2(
              countryAlpha2Code:
                  WidgetsBinding.instance.platformDispatcher.locale.countryCode,
            ),
          ),
        );

  void changeCountryCode(CountryCode code) {
    state = state.copyWith(code: code, error: null);
  }

  void onPhoneChange(String phone) {
    state = state.copyWith(
      error: null,
      phone: phone.trim(),
      enableNext: phone.length > 3,
    );
  }

  Future<void> verifyPhone() async {
    state = state.copyWith(verifying: true, error: null);
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: state.code.dialCode + state.phone,
        verificationCompleted: (authCredential) async {
          final userCredential =
              await firebaseAuth.signInWithCredential(authCredential);
          final firebaseIdToken = await userCredential.user?.getIdToken() ?? '';
          final isNewUser = await authService.verifiedLogin(
            uid: userCredential.user?.uid ?? '',
            firebaseToken: firebaseIdToken,
            phone: state.code.dialCode + state.phone,
            authType: LOGIN_TYPE_PHONE,
          );
          state = state.copyWith(
            verifying: false,
            signInSuccess: true,
            isNewUser: isNewUser,
          );
        },
        verificationFailed: (error) async {
          state = state.copyWith(verifying: false, error: error);
        },
        codeSent: (verificationId, forceResendingToken) async {
          state = state.copyWith(
            verifying: false,
            verificationId: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }
}

@freezed
class SignInWithPhoneState with _$SignInWithPhoneState {
  const factory SignInWithPhoneState({
    required CountryCode code,
    @Default(false) bool verifying,
    @Default(false) bool signInSuccess,
    String? verificationId,
    @Default(false) bool enableNext,
    Object? error,
    @Default(false) bool isNewUser,
    @Default('') String phone,
  }) = _SignInWithPhoneState;
}
