import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/model/location.dart';

const String kAPIKey = 'a861994b4c2b4bb4b6a153751231211';

Future<ForecastModel> getForecastByLocation(LocationModel location) async {
  http.Response response = await http.post(
    Uri.https(
      'api.weatherapi.com',
      '/v1/forecast.json', {
        'key': kAPIKey,
        'q': location.query,
        'aqi': 'yes',
        'days': '3',
        'alerts': 'no'
      }
    )
  );

  return ForecastModel.fromJSON(jsonDecode(response.body));
}