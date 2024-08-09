import 'dart:async';
import 'dart:ui' as ui;

import 'package:data/api/space/space_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:style/animation/on_tap_scale.dart';
import 'package:style/extenstions/context_extenstions.dart';
import 'package:style/text/app_text_dart.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';
import 'package:yourspace_flutter/ui/components/error_snakebar.dart';

import '../../../app_route.dart';
import '../../../components/permission_dialog.dart';
import 'components/space_user_footer.dart';
import 'map_view_model.dart';

const defaultCameraZoom = 15.0;
const defaultCameraZoomForSelectedUser = 17.0;
const markerSize = 100.0;
const placeSize = 80;

class MapScreen extends ConsumerStatefulWidget {
  final SpaceInfo? space;

  const MapScreen({super.key, this.space});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late MapViewNotifier notifier;
  GoogleMapController? _controller;
  final _cameraPosition =
      const CameraPosition(target: LatLng(0.0, 0.0), zoom: defaultCameraZoom);
  String? _mapStyle;
  bool _isDarkMode = false;

  List<Marker> _markers = [];
  List<Circle> _places = [];

  @override
  void didUpdateWidget(covariant MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.space == null ||
        oldWidget.space?.space.id != widget.space?.space.id) {
      setState(() {
        _markers = [];
        _places = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _observeMapCameraPosition();
    _observeNavigation();
    _observeMarkerChange();
    _observeShowEnableLocationPrompt(context);
    _observeMemberPlace(context);
    _observeError();

    notifier = ref.watch(mapViewStateProvider.notifier);
    final state = ref.watch(mapViewStateProvider);

    _updateMapStyle(context.brightness == Brightness.dark);
    return Stack(
      children: [
        Center(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _cameraPosition,
            style: _mapStyle,
            compassEnabled: false,
            zoomControlsEnabled: false,
            tiltGesturesEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            buildingsEnabled: false,
            circles: _places.toSet(),
            markers: _markers.toSet(),
          ),
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: _bottomFooters(state)),
      ],
    );
  }

  Widget _bottomFooters(MapViewState state) {
    final enabled = !state.hasLocationEnabled ||
        !state.hasLocationServiceEnabled ||
        !state.hasNotificationEnabled;

    return Column(
      children: [
        SpaceUserFooter(
          selectedSpace: widget.space,
          members: state.userInfo,
          selectedUser: state.selectedUser,
          isEnabled: !state.loading,
          fetchingInviteCode: state.fetchingInviteCode,
          onAddMemberTap: () {
            if (widget.space != null) {
              notifier.onAddMemberTap(widget.space!.space.id);
            }
          },
          onMemberTap: (member) {
            notifier.showMemberDetail(member);
          },
          onRelocateTap: () => notifier.getUserLastLocation(),
          onPlacesTap: () {
            final space = widget.space;
            if (space != null) {
              AppRoute.placesList(space.space.id).push(context);
            }
          },
          onDismiss: () => notifier.onDismissMemberDetail(),
        ),
        Visibility(visible: enabled, child: _permissionFooter(state))
      ],
    );
  }

  Widget _permissionFooter(MapViewState state) {
    final locationEnabled =
        state.hasLocationEnabled ? state.hasLocationServiceEnabled : true;
    final (title, subTitle) = _permissionFooterContent(state);

    return OnTapScale(
      onTap: () {
        (!locationEnabled)
            ? notifier.showEnableLocationDialog()
            : AppRoute.enablePermission.push(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        color: !locationEnabled
            ? context.colorScheme.alert
            : context.colorScheme.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.body2.copyWith(
                      color: context.colorScheme.textInversePrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: AppTextStyle.caption.copyWith(
                      color: context.colorScheme.textInverseDisabled,
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: context.colorScheme.textInversePrimary,
            )
          ],
        ),
      ),
    );
  }

  (String, String) _permissionFooterContent(MapViewState state) {
    final locationEnabled =
        state.hasLocationEnabled ? state.hasLocationServiceEnabled : true;

    String title = '';
    String subTitle = '';

    if (!state.hasLocationEnabled) {
      title = context.l10n.permission_footer_missing_location_permission_title;
    } else if (!state.hasNotificationEnabled) {
      title = context.l10n.permission_footer_title;
    } else {
      title = context.l10n.permission_footer_missing_location_permission_title;
    }

    if (!locationEnabled) {
      subTitle = context.l10n.permission_footer_location_off_subtitle;
    } else if (!state.hasFineLocationEnabled) {
      subTitle = context.l10n.permission_footer_subtitle;
    } else {
      subTitle =
          context.l10n.permission_footer_missing_location_permission_subtitle;
    }

    return (title, subTitle);
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  void _updateMapStyle(bool isDarkMode) async {
    if (_isDarkMode == isDarkMode) return;
    final style =
        await rootBundle.loadString('assets/map/map_theme_night.json');
    setState(() {
      _isDarkMode = isDarkMode;
      if (isDarkMode) {
        _mapStyle = style;
      } else {
        _mapStyle = null;
      }
    });
  }

  void _observeMapCameraPosition() {
    ref.listen(mapViewStateProvider.select((state) => state.defaultPosition),
        (previous, next) async {
      if (next != null) {
        await _controller?.animateCamera(CameraUpdate.newCameraPosition(next));
      }
    });
  }

  void _observeNavigation() {
    ref.listen(
        mapViewStateProvider.select((state) => state.spaceInvitationCode),
        (_, next) {
      if (next.isNotEmpty) {
        AppRoute.inviteCode(
                code: next, spaceName: widget.space?.space.name ?? '')
            .push(context);
      }
    });
  }

  void _observeMarkerChange() {
    ref.listen(mapViewStateProvider.select((state) => state.markers),
        (previous, next) {
      if (previous?.length != next.length) {
        _clearNonPlaceMarkers();
      }
      if (next.isNotEmpty) {
        for (final item in next) {
          _buildMarker(item);
        }
      }
    });
  }

  void _observeShowEnableLocationPrompt(BuildContext context) {
    ref.listen(mapViewStateProvider.select((state) => state.showLocationDialog),
        (_, next) {
      if (next != null) {
        showDialog(
          context: context,
          builder: (context) {
            return PermissionDialog(
              title: context.l10n.enable_location_service_title,
              subTitle1: context.l10n.enable_location_service_message,
              onDismiss: () {},
              goToSettings: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            );
          },
        );
      }
    });
  }

  void _buildMarker(UserMarker item) async {
    final marker = await _mapMarker(
      item.isSelected,
      item.userName,
      item.imageUrl,
      item.isSelected
          ? context.colorScheme.secondary
          : context.colorScheme.surface,
      context.colorScheme.primary,
      AppTextStyle.subtitle2.copyWith(color: context.colorScheme.onPrimary),
    );

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(item.userId),
            position: LatLng(item.latitude, item.longitude),
            anchor: const Offset(0.0, 1.0),
            icon: marker,
            onTap: () {
              notifier.onTapUserMarker(item.userId);
            }),
      );
    });
  }

  Future<BitmapDescriptor> _mapMarker(
    bool isSelected,
    String userName,
    ui.Image? imageUrl,
    Color markerBgColor,
    Color iconBgColor,
    TextStyle textStyle,
  ) async {
    if (imageUrl != null) {
      return await _userImageMarker(userName, imageUrl, isSelected,
          markerBgColor, iconBgColor, textStyle);
    } else {
      return await _userCharMarker(
          isSelected, userName, markerBgColor, iconBgColor, textStyle);
    }
  }

  Future<BitmapDescriptor> _userCharMarker(
    bool isSelected,
    String userName,
    Color markerBgColor,
    Color iconBgColor,
    TextStyle textStyle,
  ) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // Draw background rectangle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        const Rect.fromLTWH(0.0, 0.0, markerSize, markerSize),
        topLeft: const Radius.circular(40),
        topRight: const Radius.circular(40),
        bottomLeft: const Radius.circular(0),
        bottomRight: const Radius.circular(40),
      ),
      Paint()..color = markerBgColor,
    );

    _drawUserName(canvas, userName, iconBgColor);

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(markerSize.toInt(), markerSize.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final bitmapDescriptor =
        BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

    return bitmapDescriptor;
  }

  void _drawUserName(Canvas canvas, String userName, Color bgColor) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    canvas.drawCircle(const Offset(markerSize / 2, markerSize / 2), 40,
        Paint()..color = bgColor);

    textPainter.text = TextSpan(
      text: userName.isNotEmpty ? userName[0] : '',
      style: const TextStyle(fontSize: 50, color: Colors.white),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (markerSize - textPainter.width) / 2,
        (markerSize - textPainter.height) / 2,
      ),
    );
  }

  Future<BitmapDescriptor> _userImageMarker(
    String userName,
    ui.Image uiImage,
    bool isSelected,
    Color markerBgColor,
    Color iconBgColor,
    TextStyle textStyle,
  ) async {
    // Prepare the canvas to draw the rounded rectangle and the image
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0, 0), const Offset(markerSize, markerSize)));

    // Draw the rounded rectangle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        const Rect.fromLTWH(0.0, 0.0, markerSize, markerSize),
        topLeft: const Radius.circular(40),
        topRight: const Radius.circular(40),
        bottomLeft: const Radius.circular(0),
        bottomRight: const Radius.circular(40),
      ),
      Paint()..color = markerBgColor,
    );

    // Calculate the position to center the image
    final double imageOffset = (markerSize - uiImage.width.toDouble()) / 2;
    final Offset offset = Offset(imageOffset, imageOffset);

    // Draw the image on the canvas centered
    canvas.drawImage(uiImage, offset, Paint()..color = iconBgColor);

    // End recording and create an image from the canvas
    final picture = recorder.endRecording();
    final imgData =
        await picture.toImage(markerSize.toInt(), markerSize.toInt());
    final data = await imgData.toByteData(format: ui.ImageByteFormat.png);

    final bitmapDescriptor =
        BitmapDescriptor.fromBytes(data!.buffer.asUint8List());

    return bitmapDescriptor;
  }

  void _observeMemberPlace(BuildContext context) {
    ref.listen(mapViewStateProvider.select((state) => state.places),
        (previous, next) {
      if (previous?.length != next.length) {
        _clearPlacesAndPlaceMarkers();
      }

      if (next.isNotEmpty) {
        for (final place in next) {
          final latLng = LatLng(place.latitude, place.longitude);

          _generatePlaceMarker(place.id, latLng);
          setState(() {
            _places.add(Circle(
              circleId: CircleId(place.id),
              fillColor: context.colorScheme.primary.withOpacity(0.4),
              strokeColor: context.colorScheme.primary.withOpacity(0.6),
              strokeWidth: 1,
              center: latLng,
              radius: place.radius,
            ));
          });
        }
      }
    });
  }

  void _generatePlaceMarker(String id, LatLng latLng) async {
    final icon =
        await _createCustomIcon('assets/images/ic_place_marker_icon.png');

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("place_$id"),
          position: latLng,
          anchor: const Offset(0.5, 0.5),
          zIndex: 1,
          icon: icon,
        ),
      );
    });
  }

  Future<BitmapDescriptor> _createCustomIcon(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    final codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: placeSize,
      targetHeight: placeSize,
    );
    final frameInfo = await codec.getNextFrame();

    final byteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final resizedBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  void _clearPlacesAndPlaceMarkers() {
    setState(() {
      _places = [];
      _markers
          .removeWhere((marker) => marker.markerId.value.startsWith('place'));
    });
  }

  void _clearNonPlaceMarkers() {
    setState(() {
      _markers
          .removeWhere((marker) => !marker.markerId.value.startsWith('place'));
    });
  }

  void _observeError() {
    ref.listen(mapViewStateProvider.select((state) => state.error),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context, next.toString());
      }
    });
  }
}
