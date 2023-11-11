import 'package:flutter/material.dart';
import 'package:weather_app/model/city.dart';
import 'package:weather_app/pages/location/location_page.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: LocationPage(
        location: CityModel('Edmonton', 'AB', 'CA'),
      ),
    );
  }
}