import 'package:data/log/logger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngExtensions on LatLng {
  static String? _cachedAddress;
  static LatLng? _cachedLatLng;

  Future<String> getAddressFromLocation() async {
    if (_cachedLatLng != null &&
        _cachedLatLng!.latitude == latitude &&
        _cachedLatLng!.longitude == longitude &&
        _cachedAddress != null) {
      return _cachedAddress!;
    }

    String address = '';
    try {
      final placeMarks = await placemarkFromCoordinates(latitude, longitude);
      if (placeMarks.isNotEmpty) {
        var streets = placeMarks
            .map((placeMark) => placeMark.street)
            .where((street) => street != null)
            .where((street) =>
                street!.toLowerCase() !=
                placeMarks.last.locality?.toLowerCase())
            .where((street) => !street!.contains('+'));

        address += streets.join(', ');

        final lastPlaceMark = placeMarks.reversed.last;
        address += ', ${lastPlaceMark.subLocality ?? ''}';
        address += ', ${lastPlaceMark.locality ?? ''}';
        address += ', ${lastPlaceMark.subAdministrativeArea ?? ''}';
        address += ', ${lastPlaceMark.administrativeArea ?? ''}';
        address += ', ${lastPlaceMark.postalCode ?? ''}';
        address += ', ${lastPlaceMark.country ?? ''}';

        _cachedLatLng = LatLng(latitude, longitude);
        _cachedAddress = address;

        return address;
      }
    } catch (e) {
      logger.e('GetAddress: Error while getting address', error: e);
    }
    return '';
  }
}
