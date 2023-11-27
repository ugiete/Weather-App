import 'package:weather_app/enums/condition.dart';
import 'package:weather_app/enums/units.dart';

class HourForecastModel {
  final DateTime time;
  final int tempC;
  final int tempF;
  final int feelsLikeC;
  final int feelsLikeF;
  final bool isDay;
  final String weather;
  final Condition condition;
  final int windSpeed;
  final int windAngle;
  final int pressure;
  final int precipitation;
  final int humidity;
  final int uvi;
  final int? aqi;

  const HourForecastModel(this.time, this.tempC, this.tempF, this.feelsLikeC, this.feelsLikeF, this.isDay, this.weather, this.condition, this.windSpeed, this.windAngle, this.pressure, this.precipitation, this.humidity, this.uvi, this.aqi);

  factory HourForecastModel.fromJSON(DateTime time, Map<String, dynamic> json) {
    int tempC = json['temp_c'].round();
    int tempF = json['temp_f'].round();
    int feelsLikeC = json['feelslike_c'].round();
    int feelsLikeF = json['feelslike_f'].round();
    bool isDay = json['is_day'] == 1;
    String weather = json['condition']['text'];
    Condition condition = Condition.values.firstWhere((c) => c == json['condition']['code'], orElse: () => Condition.clear);
    int windSpeed = json['wind_kph'].round();
    int windAngle = json['wind_degree'].round();
    int pressure = json['pressure_mb'].round();
    int precipitation = json['precip_mm'].round();
    int humidity = json['humidity'].round();
    int uvi = json['uv'].round();
    int? aqi = json['air_quality']?['gb-defra-index']?.round();

    return HourForecastModel(time, tempC, tempF, feelsLikeC, feelsLikeF, isDay, weather, condition, windSpeed, windAngle, pressure, precipitation, humidity, uvi, aqi);
  }

  int temp(Units unit) => unit == Units.celsius ? tempC : tempF;
  int feelsLike(Units unit) => unit == Units.celsius ? feelsLikeC : feelsLikeF;
}