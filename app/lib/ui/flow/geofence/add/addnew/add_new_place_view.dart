import 'package:data/api/place/api_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/app_route.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../components/error_snakebar.dart';
import 'add_new_place_view_model.dart';

class AddNewPlaceView extends ConsumerStatefulWidget {
  final String spaceId;

  const AddNewPlaceView({super.key, required this.spaceId});

  @override
  ConsumerState<AddNewPlaceView> createState() => _AddNewPlaceViewState();
}

class _AddNewPlaceViewState extends ConsumerState<AddNewPlaceView> {
  late AddNewPlaceViewNotifier notifier;

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(addNewPlaceStateProvider.notifier);
    final state = ref.watch(addNewPlaceStateProvider);

    _observeError();

    return AppPage(
      title: context.l10n.add_new_place_title,
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: context.mediaQueryPadding.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchTextField(),
              const SizedBox(height: 40),
              _locateOnMapView(),
              const SizedBox(height: 40),
              Text(
                context.l10n.add_new_place_suggestion_text,
                style: AppTextStyle.caption.copyWith(
                  color: context.colorScheme.textDisabled,
                ),
              ),
              const SizedBox(height: 16),
              ...state.places.map((place) {
                final isLast =
                    state.places.indexOf(place) == state.places.length - 1;
                return _placesItemView(place, isLast);
              }),
              const SizedBox(height: 24),
              state.loading ? const AppProgressIndicator() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return Column(
      children: [
        TextField(
          style: AppTextStyle.subtitle3,
          onChanged: (value) {
            notifier.onPlaceNameChanged(value.trim());
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.search,
                color: context.colorScheme.textDisabled,
              ),
            ),
            hintText: context.l10n.add_new_place_search_hint_text,
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

  Widget _locateOnMapView() {
    return OnTapScale(
      onTap: () {
        AppRoute.locateOnMapScreen(widget.spaceId).push(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.containerNormal,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: context.colorScheme.containerLow),
              child: SvgPicture.asset(
                Assets.images.icLocation,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textPrimary,
                  BlendMode.srcATop,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              context.l10n.add_new_place_location_on_map_text,
              style: AppTextStyle.subtitle3.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _placesItemView(ApiNearbyPlace place, bool isLast) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: SvgPicture.asset(
                Assets.images.icLocation,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textPrimary,
                  BlendMode.srcATop,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    style: AppTextStyle.subtitle2.copyWith(
                      color: context.colorScheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    place.formatted_address,
                    style: AppTextStyle.caption
                        .copyWith(color: context.colorScheme.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]),
        ),
        Visibility(
          visible: !isLast,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              thickness: 1,
              height: 1,
              color: context.colorScheme.outline,
            ),
          ),
        )
      ],
    );
  }

  void _observeError() {
    ref.listen(addNewPlaceStateProvider.select((state) => state.error),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }
}
