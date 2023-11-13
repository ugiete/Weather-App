import 'package:flutter/material.dart';
import 'package:weather_app/enums/condition.dart';
import 'package:weather_app/utils/weather_icon.dart';

class ForecastTile extends StatelessWidget {
  final String day;
  final Condition condition;
  final int min;
  final int max;
  final int avg;

  const ForecastTile({super.key, required this.day, required this.condition, required this.min, required this.max, required this.avg});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        day,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      title: WeatherIcon(
        isDay: true,
        condition: condition,
        color: Colors.white
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$minº',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20.0),
                backgroundColor: Colors.indigo.shade300,
                color: Colors.purpleAccent,
                value: (avg - min) / (max - min),
              )
            ),
          ),
          Text(
            '$maxº',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
        ],
      ),
    );
  }
}