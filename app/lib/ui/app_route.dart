import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yourspace_flutter/ui/flow/auth/sign_in/phone/verification/phone_verification_screen.dart';
import 'package:yourspace_flutter/ui/flow/geofence/add/locate/locate_on_map_view.dart';
import 'package:yourspace_flutter/ui/flow/geofence/add/placename/choose_place_name_view.dart';
import 'package:yourspace_flutter/ui/flow/geofence/places/places_list_view.dart';
import 'package:yourspace_flutter/ui/flow/onboard/pick_name_screen.dart';
import 'package:yourspace_flutter/ui/flow/permission/enable_permission_view.dart';
import 'package:yourspace_flutter/ui/flow/setting/contact_support/contact_support_screen.dart';
import 'package:yourspace_flutter/ui/flow/setting/profile/profile_screen.dart';
import 'package:yourspace_flutter/ui/flow/setting/setting_screen.dart';
import 'package:yourspace_flutter/ui/flow/setting/space/edit_space_screen.dart';
import 'package:yourspace_flutter/ui/flow/space/create/create_space_screen.dart';
import 'package:yourspace_flutter/ui/flow/space/invite/invite_code_screen.dart';
import 'package:yourspace_flutter/ui/flow/space/join/join_space_screen.dart';

import 'flow/auth/sign_in/phone/sign_in_with_phone_screen.dart';
import 'flow/auth/sign_in/sign_in_method_screen.dart';
import 'flow/geofence/add/addnew/add_new_place_view.dart';
import 'flow/home/home_screen.dart';
import 'flow/intro/intro_screen.dart';

class AppRoute {
  static const pathPhoneNumberVerification = '/phone-number-verification';
  static const pathCreateSpace = '/create';
  static const pathJoinSpace = '/join';
  static const pathInviteCode = '/invite';
  static const pathSetting = '/setting';
  static const pathProfile = '/profile';
  static const pathEditSpace = '/space';
  static const pathContactSupport = '/contact-support';
  static const pathEnablePermission = '/enable-permission';
  static const pathPlacesList = '/places-list';
  static const pathAddNewPlace = '/add-new-place';
  static const pathLocateOnMap = "/locate_on_map";
  static const pathChoosePlace = "/choose_place";

  final String path;
  final String? name;
  final WidgetBuilder builder;

  const AppRoute(
    this.path, {
    this.name,
    required this.builder,
  });

  void go(BuildContext context) {
    if (name != null) {
      GoRouter.of(context).goNamed(name!, extra: builder);
    } else {
      GoRouter.of(context).go(path, extra: builder);
    }
  }

  static void popTo(
    BuildContext context,
    String path, {
    bool inclusive = false,
  }) {
    while (GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .matches
            .last
            .matchedLocation !=
        path) {
      if (!GoRouter.of(context).canPop()) {
        return;
      }
      GoRouter.of(context).pop();
    }

    if (inclusive && GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
  }

  Future<T?> push<T extends Object?>(BuildContext context) {
    if (name != null) {
      return GoRouter.of(context).pushNamed(name!, extra: builder);
    } else {
      return GoRouter.of(context).push(path, extra: builder);
    }
  }

  Future<T?> pushReplacement<T extends Object?>(BuildContext context) {
    if (name != null) {
      return GoRouter.of(context).pushReplacementNamed(name!, extra: builder);
    } else {
      return GoRouter.of(context).pushReplacement(path, extra: builder);
    }
  }

  Future<T?> pushNamed<T extends Object?>(BuildContext context) {
    if (name == null) {
      throw UnsupportedError('Name has to be set to use this feature!');
    }
    return GoRouter.of(context).pushNamed(name!, extra: builder);
  }

  GoRoute goRoute() => GoRoute(
        path: path,
        name: path,
        builder: (context, state) => state.widget(context),
      );

  static AppRoute get intro =>
      AppRoute("/intro", builder: (_) => const IntroScreen());

  static AppRoute get home =>
      AppRoute("/home", builder: (_) => const HomeScreen());

  static AppRoute get signInMethod =>
      AppRoute("/sign-in", builder: (_) => const SignInMethodScreen());

  static AppRoute get signInWithPhone => AppRoute(
        "/sign-in-with-phone",
        builder: (_) => const SignInWithPhoneScreen(),
      );

  static AppRoute get pickName => AppRoute(
        "/pick-name",
        builder: (_) => const PickNameScreen(),
      );

  static AppRoute otpVerification(
      {required String phoneNumber, required String verificationId}) {
    return AppRoute(
      pathPhoneNumberVerification,
      builder: (_) => PhoneVerificationScreen(phoneNumber, verificationId),
    );
  }

  static AppRoute get createSpace =>
      AppRoute(pathCreateSpace, builder: (_) => const CreateSpace());

  static AppRoute get joinSpace =>
      AppRoute(pathJoinSpace, builder: (_) => const JoinSpace());

  static AppRoute inviteCode(
      {required String code, required String spaceName}) {
    return AppRoute(
      pathInviteCode,
      builder: (_) => InviteCode(spaceName: spaceName, inviteCode: code),
    );
  }

  static AppRoute get enablePermission => AppRoute(pathEnablePermission,
      builder: (_) => const EnablePermissionView());

  static AppRoute get setting =>
      AppRoute(pathCreateSpace, builder: (_) => const SettingScreen());

  static AppRoute get profile =>
      AppRoute(pathProfile, builder: (_) => const ProfileScreen());

  static AppRoute editSpace(String spaceId) {
    return AppRoute(
      pathEditSpace,
      builder: (_) => EditSpaceScreen(spaceId: spaceId),
    );
  }

  static AppRoute get contactSupport => AppRoute(pathContactSupport,
      builder: (_) => const ContactSupportScreen());

  static AppRoute placesList(String spaceId) {
    return AppRoute(pathPlacesList,
        builder: (_) => PlacesListView(spaceId: spaceId));
  }

  static AppRoute addNewPlace(String spaceId) {
    return AppRoute(
      pathAddNewPlace,
      builder: (_) => AddNewPlaceView(spaceId: spaceId),
    );
  }

  static AppRoute locateOnMapScreen(String spaceId) {
    return AppRoute(pathLocateOnMap,
        builder: (_) => LocateOnMapView(spaceId: spaceId));
  }

  static AppRoute choosePlaceName(LatLng location, String spaceId) {
    return AppRoute(
      pathChoosePlace,
      builder: (_) => ChoosePlaceNameView(
        location: location,
        spaceId: spaceId,
      ),
    );
  }

  static final routes = [
    GoRoute(
        path: intro.path,
        builder: (context, state) {
          return state.extra == null
              ? const IntroScreen()
              : state.widget(context);
        }),
    GoRoute(
      path: pickName.path,
      builder: (context, state) {
        return state.extra == null
            ? const PickNameScreen()
            : state.widget(context);
      },
    ),
    GoRoute(
      path: home.path,
      builder: (context, state) {
        return state.extra == null ? const HomeScreen() : state.widget(context);
      },
    ),
    GoRoute(
      path: signInMethod.path,
      builder: (context, state) {
        return state.extra == null
            ? const SignInMethodScreen()
            : state.widget(context);
      },
    ),
    signInWithPhone.goRoute(),
    GoRoute(
        path: pathPhoneNumberVerification,
        builder: (context, state) {
          return state.extra == null
              ? const PhoneVerificationScreen('', '')
              : state.widget(context);
        }),
    GoRoute(
      path: pathCreateSpace,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathJoinSpace,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathInviteCode,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathSetting,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathProfile,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathEditSpace,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathContactSupport,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathEnablePermission,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathPlacesList,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddNewPlace,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathLocateOnMap,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathChoosePlace,
      builder: (context, state) => state.widget(context),
    )
  ];
}

extension GoRouterStateExtensions on GoRouterState {
  Widget widget(BuildContext context) => (extra as WidgetBuilder)(context);
}
