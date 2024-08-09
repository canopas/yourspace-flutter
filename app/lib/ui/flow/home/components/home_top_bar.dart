import 'package:data/api/space/space_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/button/icon_primary_button.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';

import '../../../../gen/assets.gen.dart';

class HomeTopBar extends StatefulWidget {
  final void Function(SpaceInfo) onSpaceItemTap;
  final void Function() onAddMemberTap;
  final void Function() onToggleLocation;
  final List<SpaceInfo> spaces;
  final SpaceInfo? selectedSpace;
  final bool loading;
  final bool fetchingInviteCode;
  final bool locationEnabled;
  final bool enablingLocation;

  const HomeTopBar({
    super.key,
    required this.spaces,
    required this.onSpaceItemTap,
    required this.onAddMemberTap,
    required this.onToggleLocation,
    required this.selectedSpace,
    this.loading = false,
    this.fetchingInviteCode = false,
    required this.locationEnabled,
    required this.enablingLocation,
  });

  @override
  State createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar> with TickerProviderStateMixin {
  bool expand = false;
  late int selectedIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void performAnimation() {
    if (expand) {
      _animationController.forward();
    } else {
      _animationController.reverse(from: 1.0).orCancel;
    }
  }

  void performArrowButtonAnimation() {
    if (expand) {
      _buttonController.reverse(from: 0.5);
    } else {
      _buttonController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return _topBar(context);
  }

  Widget _topBar(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        color: context.colorScheme.surface,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  _iconButton(
                      context: context,
                      icon: Assets.images.icSetting,
                      visibility: !expand,
                      onTap: () {
                        AppRoute.setting.push(context);
                      }),
                  const SizedBox(width: 8),
                  _spaceSelection(
                    context: context,
                    spaceName: widget.selectedSpace?.space.name ??
                        context.l10n.home_select_space_text,
                  ),
                  const SizedBox(width: 8),
                  if (widget.selectedSpace != null &&
                      widget.spaces.isNotEmpty) ...[
                    _iconButton(
                      context: context,
                      icon: Assets.images.icMessage,
                      visibility: !expand,
                      onTap: () {
                        if (widget.selectedSpace != null) {
                          AppRoute.message(widget.selectedSpace!).push(context);
                        }
                      },
                    ),
                    SizedBox(width: expand ? 0 : 8),
                  ],
                  _iconButton(
                    context: context,
                    icon: widget.locationEnabled
                        ? Assets.images.icLocation
                        : Assets.images.icLocationOff,
                    visibility: !expand,
                    progress: widget.enablingLocation,
                    onTap: () => widget.onToggleLocation(),
                  ),
                  _iconButton(
                    context: context,
                    icon: Assets.images.icAddMember,
                    visibility: expand,
                    color: context.colorScheme.textPrimary,
                    onTap: () {
                      if (widget.selectedSpace != null) {
                        widget.onAddMemberTap();
                      }
                    },
                  ),
                ],
              ),
              _dropDown(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spaceSelection({
    required BuildContext context,
    required String spaceName,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          setState(() {
            expand = !expand;
            performAnimation();
            performArrowButtonAnimation();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            border: Border.all(
              color: context.colorScheme.outline,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.loading
                        ? context.l10n.home_select_space_text
                        : widget.spaces.isEmpty
                            ? context.l10n.home_select_space_text
                            : spaceName,
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                ),
                if (widget.fetchingInviteCode ||
                    (widget.selectedSpace == null && widget.loading)) ...[
                  const AppProgressIndicator(
                      size: AppProgressIndicatorSize.small)
                ] else ...[
                  RotationTransition(
                    turns:
                        Tween(begin: 0.0, end: 1.0).animate(_buttonController),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: context.colorScheme.textPrimary,
                    ),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required BuildContext context,
    required String icon,
    Color? color,
    required bool visibility,
    required Function() onTap,
    bool progress = false,
  }) {
    return Visibility(
      visible: visibility,
      child: IconPrimaryButton(
        onTap: () => onTap(),
        progress: progress,
        icon: SvgPicture.asset(
          height: 16,
          width: 14,
          icon,
          colorFilter: ColorFilter.mode(
            color ?? context.colorScheme.textPrimary,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }

  Widget _spaceList(BuildContext context, List<SpaceInfo> spaces) {
    if (widget.loading) {
      return const AppProgressIndicator(size: AppProgressIndicatorSize.small);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: spaces.asMap().entries.map((entry) {
        final index = entry.key;
        final space = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSpaceItemTap(space);
            },
            child: _spaceListItem(
              context,
              space,
              index,
              widget.selectedSpace?.space.id == space.space.id,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _spaceListItem(
    BuildContext context,
    SpaceInfo space,
    int index,
    bool isSelected,
  ) {
    if (space.members.isEmpty) {
      return const SizedBox();
    }
    final admin = space.members.where(
      (member) => member.user.id == space.space.admin_id,
    );
    final fullName = admin.isEmpty ? "" : admin.first.user.fullName;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          widget.onSpaceItemTap(space);
          expand = false;
          performAnimation();
          performArrowButtonAnimation();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.containerLow,
          border: Border.all(
            color:
                isSelected ? context.colorScheme.primary : Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Radio<int>(
              value: index,
              groupValue: selectedIndex,
              onChanged: (val) {
                setState(() {
                  selectedIndex = index;
                  widget.onSpaceItemTap(space);
                });
              },
              activeColor: context.colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  space.space.name,
                  style: AppTextStyle.subtitle2.copyWith(
                    color: context.colorScheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.home_space_owner_text(fullName),
                      style: AppTextStyle.caption.copyWith(
                        color: context.colorScheme.textDisabled,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: context.colorScheme.textDisabled,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      context.l10n.commonMembers(space.members.length),
                      style: AppTextStyle.caption.copyWith(
                        color: context.colorScheme.textDisabled,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDown(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 12),
          _spaceList(context, widget.spaces),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(context.l10n.home_create_space_title,
                    onPressed: () {
                  AppRoute.createSpace().push(context);
                }),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(context.l10n.home_join_space_title,
                    onPressed: () {
                  AppRoute.joinSpace().push(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
