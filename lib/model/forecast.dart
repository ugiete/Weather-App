import 'package:weather_app/model/day_forecast.dart';
import 'package:weather_app/model/hour_forecast.dart';

class ForecastModel {
  final HourForecastModel current;
  final List<HourForecastModel> hourly;
  final List<DayForecast> daily;

  const ForecastModel(this.current, this.hourly, this.daily);

  factory ForecastModel.fromJSON(Map<String, dynamic> json) {
    HourForecastModel current = HourForecastModel.fromJSON(json['current']);
    List<HourForecastModel> hourly = [];
    List<DayForecast> daily = [];

    for (Map<String, dynamic> forecast in json['forecast']['forecastday']) {
      DateTime date = DateTime.parse(forecast['date']);
      daily.add(DayForecast.fromJSON(date, forecast['day']));

      for (Map<String, dynamic> hourForecast in forecast['hour']) {
        hourly.add(HourForecastModel.fromJSON(hourForecast));
      }
    }

    return ForecastModel(current, hourly, daily);
  }
}