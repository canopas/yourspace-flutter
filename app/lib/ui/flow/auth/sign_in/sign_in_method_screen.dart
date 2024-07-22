import 'package:data/storage/app_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/components/app_logo.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/components/error_snakebar.dart';
import 'package:yourspace_flutter/ui/flow/auth/sign_in/sign_in_method_viewmodel.dart';

import '../../../../gen/assets.gen.dart';
import '../../../app_route.dart';
import 'component/sign_in_method_button.dart';

class SignInMethodScreen extends ConsumerStatefulWidget {
  const SignInMethodScreen({super.key});

  @override
  ConsumerState<SignInMethodScreen> createState() => _SignInMethodScreenState();
}

class _SignInMethodScreenState extends ConsumerState<SignInMethodScreen> {
  late SignInMethodsScreenViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(signInMethodsStateProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _listenSignInSuccess();
    _observeError();

    final bgDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          context.colorScheme.primary.withOpacity(0),
          context.colorScheme.primary.withOpacity(0.02),
          context.colorScheme.primary.withOpacity(0.12),
          context.colorScheme.primary.withOpacity(0.02),
          context.colorScheme.primary.withOpacity(0),
        ],
      ),
    );

    return AppPage(
        body: Container(
          decoration: bgDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            child: Column(
              children: [
                const SizedBox(height: 80),
                const AppLogo(),
                const Spacer(),
                _appleSignInButton(),
                _googleSignInButton(),
                _phoneSignInButton(),
                const Spacer(),
              ],
            ),
          ),
        ));
  }

  Widget _googleSignInButton() => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SignInMethodButton(
        onTap: () => notifier.signInWithGoogle(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        icon: SvgPicture.asset(
          Assets.images.icGoogleLogo,
          height: 20,
        ),
        title: context.l10n.sign_in_options_continue_with_google_btn_title,
        isLoading: ref.watch(signInMethodsStateProvider
            .select((value) => value.showGoogleLoading)),
      ));

  Widget _appleSignInButton() => Visibility(
    visible: defaultTargetPlatform == TargetPlatform.iOS,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SignInMethodButton(
        onTap: () async {
          await notifier.signInWithApple();
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: context.l10n.sign_in_options_continue_with_apple_btn_title,
        icon: const Icon(
          Icons.apple_rounded,
          color: Colors.white,
          size: 22,
        ),
        isLoading: ref.watch(signInMethodsStateProvider.select((state) => state.showAppleLoading)),
      ),
    ),
  );

  Widget _phoneSignInButton() => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SignInMethodButton(
        onTap: () async {
          final isGoogleLoading = ref.read(signInMethodsStateProvider
              .select((value) => value.showGoogleLoading));
          if (isGoogleLoading) return;
          final List<bool> data =
              await AppRoute.signInWithPhone.push(context) ?? List.empty();
          if (data.isNotEmpty && data.first == true && context.mounted) {
            onSignInSuccess();
          }
        },
        title: context.l10n.sign_in_options_continue_with_phone_btn_title,
        //  isLoading: ref.watch(signInMethodsStateProvider.select((value) => value.aho)),
      ));

  void onSignInSuccess() async {
    final user = ref.read(currentUserPod);

    if (mounted && (user?.first_name == null || user!.first_name!.isEmpty)) {
      await AppRoute.pickName.push(context);
    }

    if (mounted) AppRoute.home.go(context);
  }

  void _listenSignInSuccess() {
    ref.listen(
      signInMethodsStateProvider.select((value) => value.socialSignInCompleted),
          (previous, next) {
        if (next) {
          debugPrint('Sign-in successful');
          onSignInSuccess();
        } else {
          debugPrint('Sign-in not completed yet');
        }
      },
    );
  }

  void _observeError() {
    ref.listen(signInMethodsStateProvider.select((state) => state.error), (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }
}
