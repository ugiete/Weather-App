import 'package:flutter/material.dart';
import 'package:weather_app/app/weather_app.dart';
import 'package:weather_app/enums/units.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/services/database.dart';
import 'package:weather_app/services/storage.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await DatabaseManager().open('weather');
  LocationModel? defaultLocation = await StorageManager().getDefaultLocation();
  Units defaultUnit = await StorageManager().getAppUnit();

  runApp(WeatherApp(defaultUnit: defaultUnit, defaultLocation: defaultLocation));
}