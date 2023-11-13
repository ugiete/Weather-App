import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/day_forecast.dart';
import 'package:weather_app/pages/location/forecast_tile.dart';

class ForecastPanel extends StatelessWidget {
  final List<DayForecast> forecast;

  const ForecastPanel({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat.E();
    
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurpleAccent.shade100),
        color: Colors.indigo
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'NEXT ${forecast.length} DAYS',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: forecast.asMap().entries.map((entry) {
                return ForecastTile(
                  day: entry.key == 0
                    ? 'Today'
                    : '${formatter.format(entry.value.date)}.',
                  condition: entry.value.condition,
                  min: entry.value.tempMinC,
                  max: entry.value.tempMaxC,
                  avg: entry.value.tempAvgC,
                );
              }).toList(),
            )
          )
        ],
      ),
    );
  }
}