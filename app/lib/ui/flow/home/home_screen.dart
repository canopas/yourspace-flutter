import 'package:data/api/auth/api_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/widget_extensions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/components/error_snakebar.dart';
import 'package:yourspace_flutter/ui/components/resume_detector.dart';
import 'package:yourspace_flutter/ui/flow/home/home_screen_viewmodel.dart';
import 'package:yourspace_flutter/ui/flow/home/map/map_view_model.dart';

import '../../../domain/fcm/notification_handler.dart';
import '../../components/permission_dialog.dart';
import 'components/home_top_bar.dart';
import 'map/map_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomeViewNotifier notifier;
  late MapViewNotifier mapNotifier;
  late NotificationHandler notificationHandler;

  @override
  void initState() {
    super.initState();
    runPostFrame(() {
      notificationHandler = ref.read(notificationHandlerProvider);
      notificationHandler.init(context);

      notifier = ref.watch(homeViewStateProvider.notifier);
    });

    onResume();
  }

  void onResume() {
    // Delay request to reduce too many API calls when the app is opened
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (mounted) {
        final service = ref.read(apiUserServiceProvider);
        service.registerDevice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewStateProvider);
    _observeNavigation(state);
    _observeError();
    _observeSelectedSpace();
    _observeShowBatteryDialog(context);

    mapNotifier = ref.watch(mapViewStateProvider.notifier);

    return AppPage(
      body: ResumeDetector(
        onResume: () {
          notifier.showBatteryOptimizationDialog();
          mapNotifier.checkUserPermission();
        },
        child: _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, HomeViewState state) {
    return Padding(
      padding: context.mediaQueryPadding,
      child: Stack(
        children: [
          MapScreen(space: state.selectedSpace),
          HomeTopBar(
            spaces: state.spaceList,
            onSpaceItemTap: (name) => notifier.updateSelectedSpace(name),
            onAddMemberTap: () => notifier.onAddMemberTap(),
            onToggleLocation: () => notifier.toggleLocation(),
            selectedSpace: state.selectedSpace,
            loading: state.loading,
            fetchingInviteCode: state.fetchingInviteCode,
            locationEnabled: state.locationEnabled,
            enablingLocation: state.enablingLocation,
          ),
        ],
      ),
    );
  }

  void _observeNavigation(HomeViewState state) {
    ref.listen(
        homeViewStateProvider.select((state) => state.spaceInvitationCode),
        (_, next) {
      if (next.isNotEmpty) {
        AppRoute.inviteCode(
                code: next, spaceName: state.selectedSpace?.space.name ?? '')
            .push(context);
      }
    });
  }

  void _observeError() {
    ref.listen(homeViewStateProvider.select((state) => state.error),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }

  void _observeSelectedSpace() {
    ref.listen(homeViewStateProvider.select((state) => state.selectedSpace),
        (previous, next) {
      if (previous?.space.id != next?.space.id) {
        mapNotifier.loadData(next?.space.id);
      }
    });
  }

  void _observeShowBatteryDialog(BuildContext context) {
    ref.listen(homeViewStateProvider.select((state) => state.showBatteryDialog),
        (_, next) {
      if (next != null) {
        showDialog(
            context: context,
            builder: (context) {
              return PermissionDialog(
                title: context.l10n.battery_optimization_dialog_title,
                subTitle1: context.l10n.battery_optimization_dialog_message,
                confirmBtn:
                    context.l10n.battery_optimization_dialog_btn_change_now,
                dismissBtn: context.l10n.common_cancel,
                onDismiss: () {
                  Navigator.of(context).pop();
                },
                goToSettings: () {
                  notifier.requestIgnoreBatteryOptimizations();
                  Navigator.of(context).pop();
                },
              );
            });
      }
    });
  }
}
