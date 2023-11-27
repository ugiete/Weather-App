import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings/bloc.dart';
import 'package:weather_app/bloc/settings/state.dart';
import 'package:weather_app/enums/units.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/location/location_page.dart';
import 'package:weather_app/pages/locations/locations_page.dart';

class WeatherApp extends StatelessWidget {
  final Units defaultUnit;
  final LocationModel? defaultLocation;

  const WeatherApp({super.key, required this.defaultUnit, required this.defaultLocation});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(SettingsBlocState(defaultUnit)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        home: defaultLocation == null
          ? const LocationsPage()
          : LocationPage(location: defaultLocation!)
      ),
    );
  }
}