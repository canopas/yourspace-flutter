import 'dart:math' as math;
import 'dart:math';

import 'package:data/api/auth/auth_models.dart';
import 'package:data/api/place/api_place.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/flow/geofence/edit/edit_place_view_model.dart';
import 'package:yourspace_flutter/ui/flow/setting/profile/profile_view_model.dart';

import '../../../../domain/extenstions/widget_extensions.dart';
import '../../../components/error_snakebar.dart';
import '../../../components/user_profile_image.dart';
import 'components/place_marker.dart';

class EditPlaceView extends ConsumerStatefulWidget {
  final ApiPlace place;

  const EditPlaceView({super.key, required this.place});

  @override
  ConsumerState<EditPlaceView> createState() => _EditPlaceViewState();
}

class _EditPlaceViewState extends ConsumerState<EditPlaceView> {
  late EditPlaceViewNotifier notifier;
  late CameraPosition _cameraPosition;
  GoogleMapController? _controller;
  TextEditingController _textController = TextEditingController();
  double _radiusToPixel = 0.0;
  double _previousZoom = 0.0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.place.name);
    _cameraPosition = CameraPosition(
        target: LatLng(widget.place.latitude, widget.place.longitude),
        zoom: 16);

    runPostFrame(() {
      notifier = ref.watch(editPlaceViewStateProvider.notifier);
      notifier.loadDate(widget.place);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editPlaceViewStateProvider);
    final latLng = LatLng(state.updatedPlace?.latitude ?? 0.0,
        state.updatedPlace?.longitude ?? 0.0);

    _observeError();
    _observeMapCameraPosition(latLng);
    _observePopBack();
    _observeDeleteDialog();

    return AppPage(
      title: context.l10n.edit_place_title_text,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: state.saving
              ? const AppProgressIndicator(size: AppProgressIndicatorSize.small)
              : OnTapScale(
                  onTap: () {
                    notifier.onSavePlace();
                  },
                  child: Text(
                    context.l10n.common_save,
                    style: AppTextStyle.button.copyWith(
                      color: state.enableSave
                          ? context.colorScheme.primary
                          : context.colorScheme.textDisabled,
                    ),
                  ),
                ),
        )
      ],
      body: state.loading
          ? const Center(
              child: AppProgressIndicator(
                size: AppProgressIndicatorSize.normal,
              ),
            )
          : _body(state),
    );
  }

  Widget _body(EditPlaceState state) {
    final place = state.updatedPlace;
    if (place == null) return Container();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.85,
            child: _googleMapView(
              place.latitude,
              place.longitude,
              state.isAdmin,
              place.radius,
            ),
          ),
          Visibility(
            visible: state.isAdmin,
            child: _radiusSliderView(place.radius),
          ),
          _placeDetailView(place, state),
          const SizedBox(height: 40),
          _placeSettingView(state),
          const SizedBox(height: 40),
          _deletePlaceButton(state.isAdmin, state.deleting)
        ],
      ),
    );
  }

  Widget _googleMapView(double lat, double lng, bool isAdmin, double radius) {
    _convertZoneRadiusToPixels(LatLng(lat, lng), radius * 1.07);
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: _cameraPosition,
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer())
          },
          scrollGesturesEnabled: isAdmin,
          rotateGesturesEnabled: isAdmin,
          compassEnabled: false,
          zoomControlsEnabled: false,
          tiltGesturesEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          onCameraMove: (position) {
            notifier.onMapCameraMove(position);
          },
        ),
        IgnorePointer(child: PlaceMarker(radius: _radiusToPixel))
      ],
    );
  }

  Widget _radiusSliderView(double radius) {
    String radiusText;
    if (radius < 1609.34) {
      radiusText = '${radius.round()} m';
    } else {
      final miles = (radius / 1609.34);
      radiusText = miles % 1 == 0.0
          ? '${miles.toInt()} mi'
          : '${miles.toStringAsFixed(1)} mi';
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Slider(
              value: radius,
              onChanged: notifier.onPlaceRadiusChanged,
              min: 100,
              max: 3219,
              divisions: 100,
            ),
          ),
          Text(
            radiusText.trim(),
            style: AppTextStyle.caption
                .copyWith(color: context.colorScheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _placeDetailView(ApiPlace place, EditPlaceState state) {
    final address = state.gettingAddress
        ? context.l10n.edit_place_getting_address_text
        : state.address ?? '';
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.edit_place_detail_title_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textDisabled),
          ),
          const SizedBox(height: 16),
          _searchTextField(place.name, Icons.bookmark, state.isAdmin),
          const SizedBox(height: 16),
          _placeAddressView(address),
          const SizedBox(height: 8),
          Divider(thickness: 1, height: 1, color: context.colorScheme.outline)
        ],
      ),
    );
  }

  Widget _searchTextField(String placeName, IconData iconData, bool isAdmin) {
    return Column(
      children: [
        TextField(
          controller: _textController,
          enabled: isAdmin,
          style: AppTextStyle.subtitle3
              .copyWith(color: context.colorScheme.textPrimary),
          onChanged: (value) {
            notifier.onPlaceNameChanged(value.trim());
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                iconData,
                color: context.colorScheme.textPrimary,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            prefixIconConstraints: const BoxConstraints(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.outline),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeAddressView(String address) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: context.colorScheme.textPrimary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            address,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textPrimary),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _placeSettingView(EditPlaceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.l10n.edit_place_get_notified_title_text,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textDisabled),
          ),
        ),
        const SizedBox(height: 16),
        ...state.membersInfo.map((member) {
          final isLast =
              state.membersInfo.indexOf(member) == state.membersInfo.length - 1;
          return _memberItemView(member, state.updatedSetting, isLast);
        }),
      ],
    );
  }

  Widget _memberItemView(
    ApiUserInfo member,
    ApiPlaceMemberSetting? setting,
    bool isLast,
  ) {
    final user = member.user;
    final enableArrives = setting?.arrival_alert_for.contains(user.id) ?? false;
    final enableLeaves = setting?.leave_alert_for.contains(user.id) ?? false;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _memberProfileView(user),
              const Spacer(),
              Column(
                children: [
                  _toggleSwitch(
                    title: context.l10n.edit_place_arrives_text,
                    enable: enableArrives,
                    onChanged: (value) {
                      notifier.onToggleArrives(user.id, value);
                    },
                  ),
                  const SizedBox(height: 8),
                  _toggleSwitch(
                    title: context.l10n.edit_place_leaves_text,
                    enable: enableLeaves,
                    onChanged: (value) {
                      notifier.onToggleLeaves(user.id, value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: !isLast,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
                thickness: 1, height: 1, color: context.colorScheme.outline),
          ),
        )
      ],
    );
  }

  Widget _memberProfileView(ApiUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageAvatar(
            size: 40,
            imageUrl: user.profile_image,
            initials: user.firstChar,
          ),
          const SizedBox(width: 16),
          Text(
            user.fullName,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _toggleSwitch({
    required String title,
    required bool enable,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textDisabled),
        ),
        const SizedBox(width: 16),
        Switch(value: enable, onChanged: onChanged)
      ],
    );
  }

  Widget _deletePlaceButton(bool isAdmin, bool isDeleting) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: context.mediaQueryPadding.bottom + 24,
        ),
        child: Column(
          children: [
            isAdmin
                ? PrimaryButton(
                    progress: isDeleting,
                    context.l10n.edit_place_delete_place_btn_text,
                    background: context.colorScheme.containerLow,
                    foreground: context.colorScheme.alert,
                    onPressed: notifier.onTapDeletePlaceBtn,
                  )
                : Text(
                    context.l10n.edit_place_only_admin_edit_text,
                    style: AppTextStyle.body2
                        .copyWith(color: context.colorScheme.textSecondary),
                  )
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _observeError() {
    ref.listen(editProfileViewStateProvider.select((state) => state.error),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }

  void _observeMapCameraPosition(LatLng latLng) {
    ref.listen(editPlaceViewStateProvider.select((state) => state.radius),
        (previous, next) async {
      if (next != null) {
        final zoom = _getZoomLevel(next);
        await _controller
            ?.animateCamera(CameraUpdate.newLatLngZoom(latLng, zoom));
      }
    });
  }

  void _observePopBack() {
    ref.listen(editPlaceViewStateProvider.select((state) => state.popToBack),
        (_, next) {
      if (next != null) {
        context.pop();
      }
    });
  }

  double _getZoomLevel(double radius) {
    double scale = radius / 200;
    double zoomLevel = 16 - math.log(scale) / math.log(2);
    return zoomLevel;
  }

  void _convertZoneRadiusToPixels(
    LatLng latLang,
    double radius,
  ) async {
    final zoom = await _controller?.getZoomLevel();
    if (zoom == _previousZoom) return;
    const double earthRadius = 6378100.0;
    double lat1 = radius / earthRadius;
    double lng1 = radius / (earthRadius * cos(pi * latLang.latitude / 180));

    double lat2 = latLang.latitude + lat1 * 180 / pi;
    double lng2 = latLang.longitude + lng1 * 180 / pi;

    final p1 = await _controller
        ?.getScreenCoordinate(LatLng(latLang.latitude, latLang.longitude));
    final p2 = await _controller?.getScreenCoordinate(LatLng(lat2, lng2));

    setState(() {
      _previousZoom = zoom!;
      _radiusToPixel = (p1!.x - p2!.x).abs().toDouble();
    });
  }

  void _observeDeleteDialog() {
    ref.listen(
        editPlaceViewStateProvider.select((state) => state.showDeleteDialog),
        (_, next) {
      if (next != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  context.l10n.edit_place_delete_dialog_sub_title_text,
                ),
                actions: [
                  TextButton(
                    child: Text(
                      context.l10n.common_cancel,
                      style: AppTextStyle.button
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      context.l10n.common_delete,
                      style: AppTextStyle.button
                          .copyWith(color: context.colorScheme.alert),
                    ),
                    onPressed: () {
                      notifier.onPlaceDelete();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    });
  }
}
