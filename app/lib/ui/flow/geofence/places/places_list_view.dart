import 'package:data/api/place/api_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/components/app_page.dart';
import 'package:yourspace_flutter/ui/flow/geofence/places/places_list_view_model.dart';

import '../../../../domain/extenstions/widget_extensions.dart';
import '../../../../gen/assets.gen.dart';

class PlacesListView extends ConsumerStatefulWidget {
  final String spaceId;

  const PlacesListView({super.key, required this.spaceId});

  @override
  ConsumerState<PlacesListView> createState() => _PlacesViewState();
}

class _PlacesViewState extends ConsumerState<PlacesListView> {
  late PlacesListViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    runPostFrame(() {
      notifier = ref.watch(placesListViewStateProvider.notifier);
      notifier.loadPlaces(widget.spaceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placesListViewStateProvider);

    _observeShowDeletePlaceDialog();

    return AppPage(title: context.l10n.places_list_title, body: _body(state));
  }

  Widget _body(PlacesListState state) {
    if (state.loading) {
      return const Center(
        child: AppProgressIndicator(),
      );
    }
    final placeLength = (state.places.isEmpty) ? 0 : state.places.length + 1;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: placeLength + state.suggestions.length,
            itemBuilder: (_, index) {
              if (index < state.places.length) {
                return _placesListItem(state, state.places[index]);
              }

              if (index == state.places.length && state.places.isNotEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Divider(color: context.colorScheme.outline, height: 1),
                );
              }

              final placeIndex = (state.places.isEmpty)
                  ? index
                  : index - state.places.length - 1;

              final item = state.suggestions[placeIndex];
              return _placeItemView(
                placeName: item,
                icon: _getPlacesIcon(item),
                isSuggestion: true,
                onDeletePlace: () {},
              );
            },
          ),
        ),
        Align(alignment: Alignment.bottomRight, child: _addPlaceButton())
      ],
    );
  }

  Widget _addPlaceButton() {
    return Container(
      margin: EdgeInsets.only(
        right: 16,
        bottom: context.mediaQueryPadding.bottom + 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: context.colorScheme.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.images.icPlusIcon,
            colorFilter: ColorFilter.mode(
              context.colorScheme.onPrimary,
              BlendMode.srcATop,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.places_list_add_place_btn_text,
            style: AppTextStyle.button.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }

  Widget _placesListItem(PlacesListState state, ApiPlace item) {
    final icon = _getPlacesIcon(item.name);
    final isDeleting =
        state.deletingPlaces && state.placesToDelete?.id == item.id;
    final allowDelete = state.currentUser?.id == item.created_by;
    return _placeItemView(
      placeName: item.name,
      icon: icon,
      allowDelete: allowDelete,
      isDeleting: isDeleting,
      onDeletePlace: () {
        notifier.onClickDeletePlace(item);
      },
    );
  }

  Widget _placeItemView({
    required String placeName,
    required String icon,
    bool isSuggestion = false,
    bool allowDelete = false,
    bool isDeleting = false,
    required VoidCallback onDeletePlace,
  }) {
    final enabled = !isSuggestion && allowDelete;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: context.colorScheme.containerLowOnSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textPrimary,
                  BlendMode.srcATop,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              placeName,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          (isDeleting)
              ? const AppProgressIndicator(size: AppProgressIndicatorSize.small)
              : Visibility(
                  visible: enabled,
                  child: OnTapScale(
                    onTap: onDeletePlace,
                    child: SvgPicture.asset(
                      Assets.images.icCloseIcon,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.textPrimary,
                        BlendMode.srcATop,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  String _getPlacesIcon(String name) {
    if (name == 'Home') {
      return Assets.images.icPlacesHomeIcon;
    } else if (name == 'Work') {
      return Assets.images.icPlacesWorkIcon;
    } else if (name == 'School') {
      return Assets.images.icPlacesSchoolIcon;
    } else if (name == 'Gym') {
      return Assets.images.icPlacesGymIcon;
    } else if (name == 'Library') {
      return Assets.images.icPlacesLibraryIcon;
    } else if (name == 'Local park') {
      return Assets.images.icPlacesParkIcon;
    } else {
      return Assets.images.icLocation;
    }
  }

  void _observeShowDeletePlaceDialog() {
    ref.listen(
        placesListViewStateProvider
            .select((state) => state.showDeletePlaceDialog), (_, next) {
      if (next != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  context.l10n.places_list_delete_dialog_content_text,
                ),
                actions: [
                  TextButton(
                    child: Text(
                      context.l10n.common_cancel,
                      style: AppTextStyle.button
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                    onPressed: () {
                      notifier.dismissDeletePlaceDialog();
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
                      notifier.deletePlace();
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
