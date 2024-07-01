import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/flow/geofence/add/placename/choose_place_name_view_model.dart';

import '../../../../../domain/extenstions/widget_extensions.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../components/error_snakebar.dart';
import '../../../home/map/map_view.dart';

class ChoosePlaceNameView extends ConsumerStatefulWidget {
  final LatLng location;
  final String spaceId;

  const ChoosePlaceNameView({
    super.key,
    required this.location,
    required this.spaceId,
  });

  @override
  ConsumerState<ChoosePlaceNameView> createState() =>
      _ChoosePlaceNameViewState();
}

class _ChoosePlaceNameViewState extends ConsumerState<ChoosePlaceNameView> {
  late ChoosePlaceNameViewNotifier notifier;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    runPostFrame(() {
      notifier = ref.watch(choosePlaceViewStateProvider.notifier);
      notifier.setData(widget.location, widget.spaceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(choosePlaceViewStateProvider);

    _observeError();
    _observePopToPlacesListScreen();

    return AppPage(
      title: context.l10n.choose_place_screen_title,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchTextField(),
            const SizedBox(height: 40),
            Text(
              context.l10n.choose_place_suggestion_text,
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.textDisabled),
            ),
            const SizedBox(height: 16),
            _suggestionsView(state.suggestions),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: _addPlaceButtonView(state),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return Column(
      children: [
        TextField(
          controller: _textController,
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                _textController.text = '';
              });
            }
          },
          style: AppTextStyle.subtitle3,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.search,
                color: context.colorScheme.textDisabled,
              ),
            ),
            hintText: context.l10n.choose_place_search_hint_text,
            hintStyle: AppTextStyle.subtitle3.copyWith(
              color: context.colorScheme.textDisabled,
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

  Widget _suggestionsView(List<String>? suggestions) {
    if (suggestions == null) return Container();
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      children: suggestions.map((element) {
        return OnTapScale(
          onTap: () {
            setState(() {
              _textController.text = element;
            });
          },
          child: Chip(
            label: Text(
              element,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: context.colorScheme.containerLowOnSurface,
            side: const BorderSide(color: Colors.transparent),
          ),
        );
      }).toList(),
    );
  }

  Widget _addPlaceButtonView(ChoosePlaceViewState state) {
    final enable = _textController.text.isNotEmpty && !state.addingPlace;

    return Padding(
      padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 24),
      child: PrimaryButton(
        enabled: enable,
        progress: state.addingPlace,
        onPressed: () {
          notifier.onTapAddPlaceBtn(_textController.text);
        },
        edgeInsets: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        context.l10n.choose_place_add_place_btn_text,
        expanded: false,
      ),
    );
  }

  void _observeError() {
    ref.listen(choosePlaceViewStateProvider.select((state) => state.error),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }

  void _observePopToPlacesListScreen() {
    ref.listen(
        choosePlaceViewStateProvider.select((state) => state.popToPlaceList),
        (_, next) {
      AppRoute.popTo(context, AppRoute.pathPlacesList);
      _showPlaceAddedPrompt(
        context,
        widget.location.latitude,
        widget.location.longitude,
        _textController.text,
      );
    });
  }

  void _showPlaceAddedPrompt(
    BuildContext context,
    double lat,
    double lng,
    String placeName,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1.77,
                child: _googleMapView(lat, lng),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.choose_place_prompt_added_title_text(placeName),
                style: AppTextStyle.header1
                    .copyWith(color: context.colorScheme.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Text(
                context.l10n.choose_place_prompt_sub_title_text,
                style: AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                context.l10n.choose_place_prompt_got_it_btn_text,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _googleMapView(double lat, double lng) {
    final cameraPosition =
        CameraPosition(target: LatLng(lat, lng), zoom: defaultCameraZoom);
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          initialCameraPosition: cameraPosition,
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          compassEnabled: false,
          zoomControlsEnabled: false,
          tiltGesturesEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
        ),
        _locateMarkerView()
      ],
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
}
