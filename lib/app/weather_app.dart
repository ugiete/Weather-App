import 'package:flutter/material.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/home/home_page.dart';
import 'package:weather_app/pages/locations/locations_page.dart';

class WeatherApp extends StatelessWidget {
  final LocationModel? defaultLocation;

  const WeatherApp({super.key, required this.defaultLocation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: defaultLocation == null
        ? const LocationsPage()
        : HomePage(
          location: defaultLocation!
        )
    );
  }
}