import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings/bloc.dart';
import 'package:weather_app/bloc/settings/state.dart';
import 'package:weather_app/model/hour_forecast.dart';
import 'package:weather_app/utils/weather_icon.dart';

class ForecastCard extends StatelessWidget {
  final String time;
  final HourForecastModel forecast;
  final bool selected;

  const ForecastCard({super.key, required this.time, required this.forecast, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsBlocState>(
      builder: (BuildContext context, SettingsBlocState state) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 125.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: selected
              ? Colors.indigo.shade800
              : Colors.indigo.shade400,
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                color: Colors.grey.shade700,
                blurRadius: 4.0
              )
            ],
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                time.replaceAll(' ', '\n'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12
                )
              ),
              WeatherIcon(
                isDay: forecast.isDay,
                condition: forecast.condition,
                color: Colors.white
              ),
              Text(
                '${forecast.temp(state.unit)}º',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                )
              )
            ],
          ),
        );
      }
    );
  }
}