import 'package:weather_app/model/day_forecast.dart';
import 'package:weather_app/model/hour_forecast.dart';

class ForecastModel {
  final HourForecastModel current;
  final List<HourForecastModel> hourly;
  final List<DayForecast> daily;

  const ForecastModel(this.current, this.hourly, this.daily);

  factory ForecastModel.fromJSON(Map<String, dynamic> json) {
    DateTime now = DateTime.now();

    HourForecastModel current = HourForecastModel.fromJSON(now, json['current']);
    List<HourForecastModel> hourly = [];
    List<DayForecast> daily = [];

    for (Map<String, dynamic> forecast in json['forecast']['forecastday']) {
      DateTime date = DateTime.parse(forecast['date']);
      daily.add(DayForecast.fromJSON(date, forecast['day']));

      for (Map<String, dynamic> hourForecast in forecast['hour']) {
        DateTime time = DateTime.parse(hourForecast['time']);

        if (time.isAfter(now) || time.difference(now).inHours == 0) {
          hourly.add(HourForecastModel.fromJSON(time, hourForecast));
        }
      }
    }

    return ForecastModel(current, hourly, daily);
  }
}