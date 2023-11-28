import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/enums/units.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/services/database.dart';

class StorageManager {
  final FlutterSecureStorage storage;

  StorageManager._internal()
    : storage = const FlutterSecureStorage();

  factory StorageManager() {
    return _instance;
  }

  static final StorageManager _instance = StorageManager._internal();

  Future<Units> getAppUnit() async {
    String value = await storage.read(key: 'unit') ?? '0';

    return Units.values[int.parse(value)];
  } 

  Future<void> updateAppUnit(Units unit) async {
    await storage.write(key: 'unit', value: unit.index.toString());
  }

  Future<LocationModel?> getDefaultLocation() async {
    String? value = await storage.read(key: 'defaultLoc');

    if (value != null) {
      return DatabaseManager().getLocation(int.parse(value));
    }

    return null;
  } 

  Future<void> updateDefaultLocation(LocationModel location) async {
    await storage.write(key: 'defaultLoc', value: location.id!.toString());
  }

  Future<void> deleteDefaultLocation() async {
    await storage.delete(key: 'defaultLoc');
  }
}