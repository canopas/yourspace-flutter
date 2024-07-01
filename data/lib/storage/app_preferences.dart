import 'dart:convert';

import 'package:data/storage/preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../api/auth/auth_models.dart';

final isIntroScreenShownPod = createPrefProvider<bool>(
  prefKey: "show_intro_screen",
  defaultValue: false,
);

final isOnboardingShownPod = createPrefProvider<bool>(
  prefKey: "show_onboard_screen",
  defaultValue: false,
);

final deviceIdPod = createPrefProvider<String>(
  prefKey: "unique_device_id",
  defaultValue: const Uuid().v4(),
);

final currentUserJsonPod = createPrefProvider<String?>(
  prefKey: "user_account",
  defaultValue: null,
);

final currentUserSessionJsonPod = createPrefProvider<String?>(
  prefKey: "user_session",
  defaultValue: null,
);

final currentUserPod = Provider<ApiUser?>((ref) {
  final json = ref.watch(currentUserJsonPod);
  return json == null ? null : ApiUser.fromJson(jsonDecode(json));
});

final hasUserSession =
    Provider<bool>((ref) => ref.watch(currentUserPod) != null);

final currentSpaceId = createPrefProvider<String?>(
  prefKey: "current_space_id",
  defaultValue: null,
);

final lastBatteryDialogPod = createPrefProvider<String?>(
  prefKey: 'show_battery_dialog',
  defaultValue: null,
);
