import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/place/api_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../api/network/client.dart';
import '../config.dart';

const defaultRadius = 1500;

final placeServiceProvider = Provider(
  (ref) => PlaceService(
    ref.read(firestoreProvider),
  ),
);

class PlaceService {
  final FirebaseFirestore _db;

  PlaceService(this._db);

  CollectionReference get _spaceRef => _db.collection('spaces');

  CollectionReference spacePlacesRef(String spaceId) =>
      _spaceRef.doc(spaceId).collection('space_places');

  CollectionReference spacePlacesSettingsRef(String spaceId, String placeId) {
    return spacePlacesRef(spaceId)
        .doc(placeId)
        .collection('place_settings_by_members');
  }

  Stream<List<ApiPlace>> getAllPlacesStream(String spaceId) {
    return spacePlacesRef(spaceId).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => ApiPlace.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> deletePlace(String spaceId, String placeId) async {
    await spacePlacesRef(spaceId).doc(placeId).delete();
  }

  Future<void> addPlace(
    String spaceId,
    String name,
    double latitude,
    double longitude,
    String createdBy,
    List<String> spaceMemberIds,
  ) async {
    final placeDoc = spacePlacesRef(spaceId).doc();

    final place = ApiPlace(
      id: placeDoc.id,
      space_id: spaceId,
      created_by: createdBy,
      latitude: latitude,
      longitude: longitude,
      name: name,
      created_at: DateTime.now(),
    );

    await placeDoc.set(place.toJson());

    final settings = spaceMemberIds.map((memberId) {
      final filterIds = spaceMemberIds.where((id) => id != memberId).toList();
      return ApiPlaceMemberSetting(
        user_id: memberId,
        place_id: place.id,
        alert_enabled: true,
        leave_alert_for: filterIds,
        arrival_alert_for: filterIds,
      );
    }).toList();

    for (final setting in settings) {
      await spacePlacesSettingsRef(spaceId, place.id)
          .doc(setting.user_id)
          .set(setting.toJson());
    }
  }

  Future<List<ApiNearbyPlace>> searchNearbyPlaces(
    String query,
    String? lat,
    String? lng,
  ) async {
    final placeRadius = (lat != null && lng != null) ? defaultRadius : '';
    final String url =
        '${AppConfig.placeBaseUrl}?query=$query&location=$lat,$lng&radius=$placeRadius&key=${AppConfig.mapApiKey}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results'];
      return results.map((result) {
        return ApiNearbyPlace(
          id: result['place_id'] ?? '',
          name: result['name'] ?? '',
          formatted_address: result['formatted_address'] ?? '',
          lat: result['geometry']['location']['lat']?.toDouble() ?? 0.0,
          lng: result['geometry']['location']['lng']?.toDouble() ?? 0.0,
        );
      }).toList();
    } else {
      throw Exception('Failed to load nearby places');
    }
  }
}
