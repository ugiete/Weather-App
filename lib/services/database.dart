import 'package:sqflite/sqflite.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/services/storage.dart';

class DatabaseManager {
  Database? _db;

  DatabaseManager._internal()
    : _db = null;

  factory DatabaseManager() {
    return _instance;
  }

  static final DatabaseManager _instance = DatabaseManager._internal();

  Future<void> open(String name) async {
    String dbPath = await getDatabasesPath();
    String path = '$dbPath/$name.db';

    _db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE locations (id INTEGER PRIMARY KEY, city TEXT, region TEXT, country TEXT, lat REAL, lon REAL, tz_id TEXT);');
      }
    );
  }

  Future<void> addLocation(LocationModel location) async {
    await _db!.transaction((Transaction txn) async {
      await txn.insert('locations', location.toMap);
    });
  }

  Future<LocationModel?> getLocation(int id) async {
    List<Map<String, dynamic>> raw = await _db?.rawQuery("SELECT * FROM locations WHERE id = '$id'") ?? [];
    
    if (raw.isNotEmpty) {
      return LocationModel.fromJSON(raw.first);
    }

    return null;
  }

  Future<List<LocationModel>> listLocations() async {
    List<LocationModel> locations = [];
    List<Map<String, dynamic>> raw = await _db?.rawQuery('SELECT * FROM locations ORDER BY city ASC') ?? [];
    LocationModel? defaultLocation = await StorageManager().getDefaultLocation();

    for (Map<String, dynamic> entry in raw) {
      locations.add(LocationModel.fromJSON(entry, defaultId: defaultLocation?.id));
    }

    return locations;
  }

  Future<void> deleteLocation(LocationModel location) async {
    await _db?.delete('locations', where: 'id = ?', whereArgs: [location.id]);
  }
}