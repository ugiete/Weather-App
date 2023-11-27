import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/hour_forecast.dart';
import 'package:weather_app/pages/location/forecast_card.dart';

class HourForecastPanel extends StatelessWidget {
  final List<HourForecastModel> forecast;

  const HourForecastPanel({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('h:mm\na');
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurpleAccent.shade100),
        color: Colors.indigo
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'HOURLY FORECAST',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: forecast.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ForecastCard(
                      time: formatter.format(forecast[index].time),
                      forecast: forecast[index],
                      selected: index == 0
                    ),
                  ); 
                }
              ),
            )
          )
        ],
      ),
    );
  }
}