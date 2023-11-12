import 'package:flutter/material.dart';
import 'package:weather_app/pages/home/home_page.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: HomePage()
    );
  }
}