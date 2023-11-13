import 'package:flutter/material.dart';
import 'package:weather_app/app/weather_app.dart';
import 'package:weather_app/services/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  DatabaseManager()
    .open('weather')
    .whenComplete(() => runApp(const WeatherApp()));
}