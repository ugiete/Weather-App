import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/city.dart';
import 'package:weather_app/model/forecast.dart';

Future<ForecastModel> getForecast(CityModel location) async {
  http.Response response = await http.post(
    Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather', {
        'q': location.query,
        'appid': '307eac07e9da04d2560b2706968af830',
        'units': 'metric'
      }
    )
  );

  return ForecastModel.fromJSON(jsonDecode(response.body));
}