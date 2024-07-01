import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/flow/permission/enable_permission_view_model.dart';

import '../../components/error_snakebar.dart';
import '../../components/permission_dialog.dart';

class EnablePermissionView extends ConsumerStatefulWidget {
  const EnablePermissionView({super.key});

  @override
  ConsumerState<EnablePermissionView> createState() =>
      _EnablePermissionViewState();
}

class _EnablePermissionViewState extends ConsumerState<EnablePermissionView>
    with WidgetsBindingObserver {
  late PermissionViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    notifier = ref.read(permissionStateProvider.notifier);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      notifier.checkUserPermissions();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _observeBackgroundLocationAccessBanner(context);
    _observeShowLocationAccessPrompt(context);
    return AppPage(
      title: context.l10n.enable_permission_top_bar_text,
      body: Builder(builder: (_) {
        return _body();
      }),
    );
  }

  Widget _body() {
    final state = ref.watch(permissionStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            context.l10n.enable_permission_screen_title,
            style: AppTextStyle.body1.copyWith(
              color: context.colorScheme.textDisabled,
            ),
          ),
          const SizedBox(height: 40),
          _permissionView(
            title: context.l10n.enable_location_access_title,
            subTitle: context.l10n.enable_location_access_sub_title,
            buttonValue: state.isLocationGranted,
            onTapRadio: notifier.requestLocationPermission,
          ),
          const SizedBox(height: 24),
          _permissionView(
            title: context.l10n.enable_background_location_access_title,
            subTitle: context.l10n.enable_background_location_access_sub_title,
            buttonValue: state.isBackGroundLocationGranted,
            onTapRadio: notifier.requestBackgroundLocationPermission,
          ),
          const SizedBox(height: 24),
          _permissionView(
            title: context.l10n.enable_notification_access_title,
            subTitle: context.l10n.enable_notification_access_sun_title,
            buttonValue: state.isNotificationGranted,
            onTapRadio: notifier.requestNotificationPermission,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
                top: 24, bottom: context.mediaQueryPadding.bottom + 16),
            child: Text(
              context.l10n.enable_permission_footer,
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.textDisabled),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _permissionView({
    required String title,
    required String subTitle,
    required bool buttonValue,
    required VoidCallback onTapRadio,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Radio(
            value: true,
            groupValue: buttonValue,
            activeColor: context.colorScheme.primary,
            onChanged: (value) {
              onTapRadio();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                subTitle,
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textDisabled),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _observeBackgroundLocationAccessBanner(BuildContext context) {
    ref.listen(permissionStateProvider.select((state) => state.bgAction),
        (_, next) {
      if (next != null) {
        showErrorSnackBar(
          context,
          context.l10n.enable_background_location_access_message_text,
        );
      }
    });
  }

  void _observeShowLocationAccessPrompt(BuildContext context) {
    ref.listen(
        permissionStateProvider.select((state) => state.showLocationPrompt),
        (_, next) {
      if (next != null) {
        showDialog(
          context: context,
          builder: (context) {
            return PermissionDialog(
              title: context.l10n.enable_location_prompt_title,
              subTitle1: context.l10n.enable_location_prompt_sub_title_1,
              subTitle2: context.l10n.enable_location_prompt_sub_title_2,
              onDismiss: () {},
              goToSettings: () {
                _openAppSettingInfoScreen();
                Navigator.of(context).pop();
              },
            );
          },
        );
      }
    });
  }

  void _openAppSettingInfoScreen() async {
    await openAppSettings();
  }
}
