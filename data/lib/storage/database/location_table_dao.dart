import 'package:data/api/location/location_table.dart';
import 'package:data/storage/database/location_database.dart';
import 'package:sqflite/sqflite.dart';

class LocationTableDao {
  final LocationDatabaseHelper _locationDatabase = LocationDatabaseHelper();

  Future<void> insertLocationTable(LocationTable locationTable) async {
    final db = await _locationDatabase.database;
    await db.insert(
      LocationDatabaseHelper.tableName,
      locationTable.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<LocationTable?> getLocationData(String userId) async {
    final db = await _locationDatabase.database;
    final data = await db.query(
      LocationDatabaseHelper.tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
    if (data.isNotEmpty) {
      return LocationTable.fromJson(data.first);
    } else {
      return null;
    }
  }

  Future<void> updateLocationTable(LocationTable locationTable) async {
    final db = await _locationDatabase.database;
    await db.update(
      LocationDatabaseHelper.tableName,
      locationTable.toJson(),
      where: 'userId = ?',
      whereArgs: [locationTable.userId],
    );
  }

  Future<void> deleteLocationTable(String userId) async {
    final db = await _locationDatabase.database;
    await db.delete(
      LocationDatabaseHelper.tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}
