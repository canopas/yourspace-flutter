import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/flow/setting/subscription/subscription_view_model.dart';

import '../../../../gen/assets.gen.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  late SubscriptionViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(subscriptionViewProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subscriptionViewProvider);

    return AppPage(
        title: '',
        leading: OnTapScale(
            onTap: () => AppRoute.popBack(context),
            child: const Icon(Icons.clear, size: 24.0)),
        body: _body(state));
  }

  Widget _body(SubscriptionState state) {
    final selectedPlan = state.selectedPlan?.id ?? '';

    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: context.mediaQueryPadding.bottom,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _subscriptionInfo(),
                const SizedBox(height: 192),
                ...state.plans.map((plan) {
                  return _subscriptionPlanItem(plan, selectedPlan == plan.id);
                }),
                const SizedBox(height: 24),
              ],
            ),
          ),
          _paymentBtnView()
        ],
      ),
    );
  }

  Widget _subscriptionInfo() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          context.l10n.subscription_title,
          style: AppTextStyle.subscriptionHeader
              .copyWith(color: context.colorScheme.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          context.l10n.subscription_sub_title,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _subscriptionPlanItem(SubscriptionPlan plan, bool isSelected) {
    return OnTapScale(
      onTap: () => notifier.onSelectPlan(plan),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(18.0),
          border: isSelected
              ? Border.all(width: 1, color: context.colorScheme.primary)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SvgPicture.asset(
                isSelected
                    ? Assets.images.icSubscriptionCheckIcon
                    : Assets.images.icSubscriptionUncheckIcon,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                Text(
                  plan.planDetail,
                  style: AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textDisabled),
                ),
                const SizedBox(height: 16),
                Text(
                  plan.planInfo,
                  style: AppTextStyle.subtitle3
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _paymentBtnView() {
    return Column(children: [
      _bottomCaptions(),
      const SizedBox(height: 8),
      PrimaryButton(
        context.l10n.subscription_go_to_payment_text,
        onPressed: () {
          //Todo: on payment button tap
        },
      ),
      const SizedBox(height: 24),
    ]);
  }

  Widget _bottomCaptions() {
    final textColor = context.colorScheme.textDisabled;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.subscription_auto_renewable_text,
          style: AppTextStyle.body2.copyWith(color: textColor),
        ),
        Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(left: 6, right: 6),
          decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
        ),
        Text(
          context.l10n.subscription_cancel_anytime_text,
          style: AppTextStyle.body2.copyWith(color: textColor),
        ),
      ],
    );
  }
}
