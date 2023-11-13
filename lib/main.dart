import 'package:flutter/material.dart';
import 'package:weather_app/app/weather_app.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/services/database.dart';
import 'package:weather_app/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseManager().open('weather');
  LocationModel? defaultLocation = await StorageManager().getDefaultLocation();

  runApp(WeatherApp(defaultLocation: defaultLocation));
}