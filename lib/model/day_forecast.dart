import 'package:weather_app/enums/condition.dart';
import 'package:weather_app/enums/units.dart';

class DayForecast {
  final DateTime date;
  final int tempMaxC;
  final int tempMaxF;
  final int tempMinC;
  final int tempMinF;
  final int tempAvgC;
  final int tempAvgF;
  final String weather;
  final Condition condition;

  const DayForecast(this.date, this.tempMaxC, this.tempMaxF, this.tempMinC, this.tempMinF, this.tempAvgC, this.tempAvgF, this.weather, this.condition);

  factory DayForecast.fromJSON(DateTime date, Map<String, dynamic> json) {
    int tempMaxC = json['maxtemp_c'].round();
    int tempMaxF = json['maxtemp_f'].round();
    int tempMinC = json['mintemp_c'].round();
    int tempMinF = json['mintemp_f'].round();
    int tempAvgC = json['avgtemp_c'].round();
    int tempAvgF = json['avgtemp_f'].round();
    String weather = json['condition']['text'];
    Condition condition = Condition.values.firstWhere((c) => c == json['condition']['code'], orElse: () => Condition.clear);

    return DayForecast(date, tempMaxC, tempMaxF, tempMinC, tempMinF, tempAvgC, tempAvgF, weather, condition);
  }

  int max(Units unit) => unit == Units.celsius ? tempMaxC : tempMaxF;
  int avg(Units unit) => unit == Units.celsius ? tempAvgC : tempAvgF;
  int min(Units unit) => unit == Units.celsius ? tempMinC : tempMinF;
}