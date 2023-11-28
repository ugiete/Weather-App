import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/services/database.dart';

const String kAPIKey = 'a861994b4c2b4bb4b6a153751231211';

Future<List<LocationModel>> searchLocations(String query) async {
  List<LocationModel> locations = [];

  try {
    http.Response response = await http.post(
      Uri.https(
        'api.weatherapi.com',
        '/v1/search.json', {
          'key': kAPIKey,
          'q': query
        }
      )
    );

    for (Map<String,dynamic> json in jsonDecode(response.body)) {
      locations.add(LocationModel.fromSearch(json));
    }
  } catch (e) {
    return [];
  }

  return locations;
} 

Future<ForecastModel> getForecastByLocation(LocationModel location, {int days = 3}) async {
  http.Response response = await http.post(
    Uri.https(
      'api.weatherapi.com',
      '/v1/forecast.json', {
        'key': kAPIKey,
        'q': location.query,
        'aqi': 'yes',
        'days': days.toString(),
        'alerts': 'no'
      }
    )
  );

  Map<String, dynamic> body = jsonDecode(response.body);

  return ForecastModel.fromJSON(body, body['location']['tz_id']);
}

Future<LocationModel> getLocationByLatLon(double lat, double lon) async {
  http.Response response = await http.post(
    Uri.https(
      'api.weatherapi.com',
      '/v1/forecast.json', {
        'key': kAPIKey,
        'q': "$lat,$lon",
        'aqi': 'no',
        'days': '1',
        'alerts': 'no'
      }
    )
  );

  LocationModel location = LocationModel.fromSearch(jsonDecode(response.body)['location']);

  await DatabaseManager().addLocation(location);

  return location;
}