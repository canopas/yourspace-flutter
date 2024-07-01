import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionServiceProvider = Provider((ref) => const PermissionService());

class PermissionService {
  const PermissionService();

  Future<bool> isLocationPermissionGranted() async {
    return await Permission.location.isGranted;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  Future<bool> isBackgroundLocationPermissionGranted() async {
    return await Permission.locationAlways.isGranted;
  }

  Future<bool> requestBackgroundLocationPermission() async {
    return await requestPermission(Permission.locationAlways);
  }

  Future<bool> hasNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  Future<bool> requestNotificationPermission() async {
    return await requestPermission(Permission.notification);
  }

  Future<bool> isBatteryOptimizationEnabled() async {
    return await Permission.ignoreBatteryOptimizations.isGranted;
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    await Permission.ignoreBatteryOptimizations.request();
  }

  Future<bool> isLocationAlwaysEnabled() async {
    final isLocationEnabled = await isLocationPermissionGranted();
    final isBackgroundEnabled = await isBackgroundLocationPermissionGranted();
    return (isLocationEnabled && isBackgroundEnabled);
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.status;

    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    } else {
      return status.isGranted;
    }
  }
}
