import 'package:data/api/auth/auth_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/button/icon_primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../components/user_profile_image.dart';
import 'selected_member_detail_view.dart';

class SpaceUserFooter extends StatefulWidget {
  final List<ApiUserInfo>? members;
  final ApiUserInfo? selectedUser;
  final bool isEnabled;
  final void Function() onAddMemberTap;
  final void Function(ApiUserInfo) onMemberTap;
  final void Function() onRelocateTap;
  final void Function() onPlacesTap;
  final void Function() onDismiss;
  final void Function() onTapTimeline;

  const SpaceUserFooter({
    super.key,
    required this.members,
    this.selectedUser,
    required this.isEnabled,
    required this.onAddMemberTap,
    required this.onMemberTap,
    required this.onRelocateTap,
    required this.onPlacesTap,
    required this.onDismiss,
    required this.onTapTimeline,
  });

  @override
  State<SpaceUserFooter> createState() => _SpaceUserFooterState();
}

class _SpaceUserFooterState extends State<SpaceUserFooter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          _mapControlBtn(context),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: widget.selectedUser != null
                ? SelectedMemberDetailView(
                    key: const ValueKey('detailView'),
                    userInfo: widget.selectedUser,
                    onDismiss: widget.onDismiss,
                    onTapTimeline: widget.onTapTimeline,
                  )
                : const SizedBox.shrink(
                    key: ValueKey('emptyBox'),
                  ),
          ),
          Visibility(
              visible: widget.isEnabled &&
                  widget.members != null &&
                  widget.members!.isNotEmpty,
              child: selectedSpaceMemberView(
                context: context,
                members: widget.members,
              )),
        ],
      ),
    );
  }

  Widget _mapControlBtn(BuildContext context) {
    return SizedBox(
      width: context.mediaQuerySize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _iconButton(
            context: context,
            icon: Assets.images.icRelocateIcon,
            iconSize: 24,
            foreground: context.colorScheme.primary,
            background: context.colorScheme.surface,
            onTap: widget.onRelocateTap,
          ),
          const SizedBox(height: 16),
          _iconButton(
            context: context,
            icon: Assets.images.icGeofenceIcon,
            iconSize: 24,
            foreground: context.colorScheme.onPrimary,
            background: context.colorScheme.primary,
            onTap: widget.onPlacesTap,
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }

  Widget _iconButton({
    required BuildContext context,
    required String icon,
    required double iconSize,
    required Color foreground,
    required Color background,
    bool visibility = true,
    required Function() onTap,
  }) {
    return Visibility(
      visible: visibility,
      child: IconPrimaryButton(
        backgroundColor: background,
        onTap: () => onTap(),
        icon: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            foreground,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }

  Widget selectedSpaceMemberView({
    required BuildContext context,
    required List<ApiUserInfo>? members,
  }) {
    if (members == null || members.isEmpty) return Container();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: context.colorScheme.surface),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          addMemberView(context),
          ...members.map((item) => spaceMemberItem(context, item)),
        ],
      ),
    );
  }

  Widget addMemberView(BuildContext context) {
    return OnTapScale(
      onTap: widget.onAddMemberTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: context.colorScheme.primary, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Assets.images.icAddUserIcon,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.primary,
                    BlendMode.srcATop,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              context.l10n.common_add,
              maxLines: 1,
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget spaceMemberItem(
    BuildContext context,
    ApiUserInfo userInfo,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: OnTapScale(
        onTap: () {
          widget.onMemberTap(userInfo);
        },
        child: SizedBox(
          width: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageAvatar(
                size: 40,
                imageUrl: userInfo.user.profile_image,
                initials: userInfo.user.firstChar,
              ),
              const SizedBox(height: 2),
              Text(
                userInfo.user.first_name ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyle.caption
                    .copyWith(color: context.colorScheme.textPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
