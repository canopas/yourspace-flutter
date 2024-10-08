import 'dart:async';

import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/lat_lng_extenstion.dart';
import 'package:yourspace_flutter/domain/extenstions/time_ago_extenstions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/profile_picture.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../components/user_battery_status.dart';

class SelectedMemberDetailView extends StatefulWidget {
  final ApiUserInfo? userInfo;
  final void Function() onDismiss;

  const SelectedMemberDetailView({
    super.key,
    required this.userInfo,
    required this.onDismiss,
  });

  @override
  State<SelectedMemberDetailView> createState() =>
      _SelectedMemberDetailViewState();
}

class _SelectedMemberDetailViewState extends State<SelectedMemberDetailView> {
  String? address = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    getAddressDebounced(widget.userInfo?.location);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SelectedMemberDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.userInfo?.user.id != widget.userInfo?.user.id) {
      _debounce?.cancel();

      setState(() {
        address = '';
      });

      getAddressDebounced(widget.userInfo?.location);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = widget.userInfo;
    return userInfo != null ? _userDetailCardView(userInfo) : Container();
  }

  Widget _userDetailCardView(ApiUserInfo userInfo) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.colorScheme.surface),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userProfileView(userInfo),
                const SizedBox(width: 16),
                Expanded(child: _userDetailView(userInfo)),
              ],
            ),
          ),
        ),
        Container(
          width: context.mediaQuerySize.width,
          padding: const EdgeInsets.only(top: 24, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_timeLineButtonView()],
          ),
        ),
        OnTapScale(
          onTap: () => widget.onDismiss(),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: context.colorScheme.surface),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SvgPicture.asset(
                Assets.images.icDownArrowIcon,
                colorFilter: ColorFilter.mode(
                    context.colorScheme.textDisabled, BlendMode.srcATop),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _userProfileView(ApiUserInfo userInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImage(
          profileImageUrl: userInfo.user.profile_image!,
          firstLetter: userInfo.user.firstChar,
          size: 48,
          backgroundColor: context.colorScheme.primary,
        ),
        const SizedBox(height: 2),
        UserBatteryStatus(userInfo: userInfo)
      ],
    );
  }

  Widget _userDetailView(ApiUserInfo userInfo) {
    final (userState, textColor) = selectedUserState(userInfo.user);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userInfo.user.fullName,
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 4),
        Text(userState, style: AppTextStyle.caption.copyWith(color: textColor)),
        const SizedBox(height: 12),
        _userAddressView(userInfo.location),
        const SizedBox(height: 4),
        _userTimeAgo(userInfo.user.created_at)
      ],
    );
  }

  Widget _userAddressView(ApiLocation? location) {
    return Text(
      address ?? '',
      style: AppTextStyle.body2.copyWith(
        color: context.colorScheme.textPrimary,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _timeLineButtonView() {
    return OnTapScale(
      onTap: () {
        AppRoute.journeyTimeline(widget.userInfo!.user).push(context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: context.colorScheme.containerLow),
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          Assets.images.icTimeLineHistoryIcon,
          colorFilter: ColorFilter.mode(
            context.colorScheme.textPrimary,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }

  Widget _userTimeAgo(int? createdAt) {
    return Row(
      children: [
        Icon(
          Icons.access_time_outlined,
          color: context.colorScheme.textDisabled,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          createdAt.timeAgo(),
          style: AppTextStyle.caption
              .copyWith(color: context.colorScheme.textDisabled),
        )
      ],
    );
  }

  void getAddressDebounced(ApiLocation? location) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      getAddress(location);
    });
  }

  void getAddress(ApiLocation? location) async {
    if (location != null) {
      final latLng = LatLng(location.latitude, location.longitude);
      final fetchedAddress = await latLng.getAddressFromLocation();

      if (mounted) {
        setState(() {
          address = fetchedAddress;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          address = 'Location not available';
        });
      }
    }
  }

  (String, Color) selectedUserState(ApiUser user) {
    if (user.noNetWork) {
      return (
        context.l10n.map_selected_user_item_no_network_state_text,
        context.colorScheme.textSecondary
      );
    } else if (user.locationPermissionDenied) {
      return (
        context.l10n.map_selected_user_item_location_off_state_text,
        context.colorScheme.alert
      );
    } else {
      return (
        context.l10n.map_selected_user_item_online_state_text,
        context.colorScheme.positive
      );
    }
  }
}
