import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/button/icon_primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/flow/geofence/add/locate/locate_on_map_view_model.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../home/map/map_view.dart';

class LocateOnMapView extends ConsumerStatefulWidget {
  final String spaceId;

  const LocateOnMapView({super.key, required this.spaceId});

  @override
  ConsumerState<LocateOnMapView> createState() => _LocateOnMapViewState();
}

class _LocateOnMapViewState extends ConsumerState<LocateOnMapView> {
  late LocateOnMapVieNotifier notifier;
  final _cameraPosition =
      const CameraPosition(target: LatLng(0.0, 0.0), zoom: defaultCameraZoom);

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(locateOnMapViewStateProvider.notifier);
    final state = ref.watch(locateOnMapViewStateProvider);
    final centerPosition = state.centerPosition;
    final enable = centerPosition != null
        ? centerPosition.target != _cameraPosition.target
        : false;

    return AppPage(
      title: context.l10n.locate_on_map_title,
      actions: [
        OnTapScale(
          enabled: enable,
          onTap: () {
            if (centerPosition != null) {
              AppRoute.choosePlaceName(centerPosition.target, widget.spaceId)
                  .push(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.common_next,
              style: AppTextStyle.button.copyWith(
                color: enable
                    ? context.colorScheme.primary
                    : context.colorScheme.textDisabled,
              ),
            ),
          ),
        )
      ],
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding:
          EdgeInsets.only(top: 16, bottom: context.mediaQueryPadding.bottom),
      child: Stack(children: [
        Center(
          child: GoogleMap(
            initialCameraPosition: _cameraPosition,
            compassEnabled: false,
            zoomControlsEnabled: false,
            tiltGesturesEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            buildingsEnabled: false,
            onCameraMove: notifier.showLocateBtn,
          ),
        ),
        Center(child: _locateMarkerView()),
        Align(
            alignment: Alignment.bottomRight, child: _locateIconButton(context))
      ]),
    );
  }

  Widget _locateMarkerView() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: context.colorScheme.onPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          Assets.images.icLocationFeedIcon,
          colorFilter: ColorFilter.mode(
            context.colorScheme.primary,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }

  Widget _locateIconButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: IconPrimaryButton(
        backgroundColor: context.colorScheme.onPrimary,
        onTap: () {},
        icon: SvgPicture.asset(
          Assets.images.icRelocateIcon,
          colorFilter: ColorFilter.mode(
            context.colorScheme.primary,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }
}
