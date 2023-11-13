import 'package:flutter/material.dart';
import 'package:weather_app/pages/location/forecast_tile.dart';

class ForecastPanel extends StatelessWidget {
  const ForecastPanel({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'NEXT 3 DAYS',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ForecastTile(day: 'Today', icon: Icons.cloud, min: 0, max: 10)
          ),
          const ForecastTile(day: 'Tue.', icon: Icons.sunny, min: 0, max: 10),
          const ForecastTile(day: 'Wed.', icon: Icons.cloud, min: 0, max: 10),
        ],
      ),
    );
  }
}