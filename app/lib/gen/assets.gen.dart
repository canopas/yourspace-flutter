/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/ic_30_battery_icon.svg
  String get ic30BatteryIcon => 'assets/images/ic_30_battery_icon.svg';

  /// File path: assets/images/ic_50_battery_icon.svg
  String get ic50BatteryIcon => 'assets/images/ic_50_battery_icon.svg';

  /// File path: assets/images/ic_about_us.svg
  String get icAboutUs => 'assets/images/ic_about_us.svg';

  /// File path: assets/images/ic_add_member.svg
  String get icAddMember => 'assets/images/ic_add_member.svg';

  /// File path: assets/images/ic_add_user_icon.svg
  String get icAddUserIcon => 'assets/images/ic_add_user_icon.svg';

  /// File path: assets/images/ic_close_icon.svg
  String get icCloseIcon => 'assets/images/ic_close_icon.svg';

  /// File path: assets/images/ic_contact_support.svg
  String get icContactSupport => 'assets/images/ic_contact_support.svg';

  /// File path: assets/images/ic_down_arrow_icon.svg
  String get icDownArrowIcon => 'assets/images/ic_down_arrow_icon.svg';

  /// File path: assets/images/ic_edit_profile.svg
  String get icEditProfile => 'assets/images/ic_edit_profile.svg';

  /// File path: assets/images/ic_empty_battery_icon.svg
  String get icEmptyBatteryIcon => 'assets/images/ic_empty_battery_icon.svg';

  /// File path: assets/images/ic_full_bettery_icon.svg
  String get icFullBetteryIcon => 'assets/images/ic_full_bettery_icon.svg';

  /// File path: assets/images/ic_geofence_icon.svg
  String get icGeofenceIcon => 'assets/images/ic_geofence_icon.svg';

  /// File path: assets/images/ic_google_logo.svg
  String get icGoogleLogo => 'assets/images/ic_google_logo.svg';

  /// File path: assets/images/ic_location.svg
  String get icLocation => 'assets/images/ic_location.svg';

  /// File path: assets/images/ic_message.svg
  String get icMessage => 'assets/images/ic_message.svg';

  /// File path: assets/images/ic_place_marker_icon.png
  AssetGenImage get icPlaceMarkerIcon =>
      const AssetGenImage('assets/images/ic_place_marker_icon.png');

  /// File path: assets/images/ic_places_gym_icon.svg
  String get icPlacesGymIcon => 'assets/images/ic_places_gym_icon.svg';

  /// File path: assets/images/ic_places_home_icon.svg
  String get icPlacesHomeIcon => 'assets/images/ic_places_home_icon.svg';

  /// File path: assets/images/ic_places_library_icon.svg
  String get icPlacesLibraryIcon => 'assets/images/ic_places_library_icon.svg';

  /// File path: assets/images/ic_places_park_icon.svg
  String get icPlacesParkIcon => 'assets/images/ic_places_park_icon.svg';

  /// File path: assets/images/ic_places_school_icon.svg
  String get icPlacesSchoolIcon => 'assets/images/ic_places_school_icon.svg';

  /// File path: assets/images/ic_places_work_icon.svg
  String get icPlacesWorkIcon => 'assets/images/ic_places_work_icon.svg';

  /// File path: assets/images/ic_plus_icon.svg
  String get icPlusIcon => 'assets/images/ic_plus_icon.svg';

  /// File path: assets/images/ic_privacy_policy.svg
  String get icPrivacyPolicy => 'assets/images/ic_privacy_policy.svg';

  /// File path: assets/images/ic_relocate_icon.svg
  String get icRelocateIcon => 'assets/images/ic_relocate_icon.svg';

  /// File path: assets/images/ic_remove.svg
  String get icRemove => 'assets/images/ic_remove.svg';

  /// File path: assets/images/ic_setting.svg
  String get icSetting => 'assets/images/ic_setting.svg';

  /// File path: assets/images/ic_sign_out.svg
  String get icSignOut => 'assets/images/ic_sign_out.svg';

  /// File path: assets/images/ic_time_line_history_icon.svg
  String get icTimeLineHistoryIcon =>
      'assets/images/ic_time_line_history_icon.svg';

  /// File path: assets/images/intro_1.svg
  String get intro1 => 'assets/images/intro_1.svg';

  /// File path: assets/images/intro_2.svg
  String get intro2 => 'assets/images/intro_2.svg';

  /// File path: assets/images/intro_3.svg
  String get intro3 => 'assets/images/intro_3.svg';

  /// File path: assets/images/intro_bg.jpg
  AssetGenImage get introBg =>
      const AssetGenImage('assets/images/intro_bg.jpg');

  /// List of all assets
  List<dynamic> get values => [
        appLogo,
        ic30BatteryIcon,
        ic50BatteryIcon,
        icAboutUs,
        icAddMember,
        icAddUserIcon,
        icCloseIcon,
        icContactSupport,
        icDownArrowIcon,
        icEditProfile,
        icEmptyBatteryIcon,
        icFullBetteryIcon,
        icGeofenceIcon,
        icGoogleLogo,
        icLocation,
        icMessage,
        icPlaceMarkerIcon,
        icPlacesGymIcon,
        icPlacesHomeIcon,
        icPlacesLibraryIcon,
        icPlacesParkIcon,
        icPlacesSchoolIcon,
        icPlacesWorkIcon,
        icPlusIcon,
        icPrivacyPolicy,
        icRelocateIcon,
        icRemove,
        icSetting,
        icSignOut,
        icTimeLineHistoryIcon,
        intro1,
        intro2,
        intro3,
        introBg
      ];
}

class $AssetsMapGen {
  const $AssetsMapGen();

  /// File path: assets/map/map_theme_night.json
  String get mapThemeNight => 'assets/map/map_theme_night.json';

  /// List of all assets
  List<String> get values => [mapThemeNight];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMapGen map = $AssetsMapGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
