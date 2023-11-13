import 'package:flutter/material.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/pages/location/air_quality.dart';
import 'package:weather_app/pages/location/daylight.dart';
import 'package:weather_app/pages/location/feels_like.dart';
import 'package:weather_app/pages/location/humidity.dart';
import 'package:weather_app/pages/location/precipitation.dart';
import 'package:weather_app/pages/location/pressure.dart';
import 'package:weather_app/pages/location/uv_index.dart';
import 'package:weather_app/pages/location/visibility.dart';
import 'package:weather_app/pages/location/wind.dart';
import 'package:weather_app/services/weather_api.dart';

class LocationPage extends StatefulWidget {
  final LocationModel location;
  final ForecastModel? initialForecast;

  const LocationPage({super.key, required this.location, this.initialForecast});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late ForecastModel forecast;
  late bool loading;

  Future<void> loadForecast() async {
    forecast = await getForecast(widget.location);

    setState(() {
      loading = false;  
    });
  }

  @override
  void initState() {
    if (widget.initialForecast != null) {
      forecast = widget.initialForecast!;
      loading = false;
    } else {
      loading = true;
    }

    super.initState();

    loadForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF2F2F55),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          color: const Color(0xFF2F2F55).withAlpha(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.location.city,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white
                ),
              ),
              Text(
                loading
                  ? '-'
                  : '${forecast.temperature}º | ${forecast.main}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),
              )
            ],
          ),
        )
      ),
      body: loading
      ? const Center(
        child: CircularProgressIndicator(
          color: Colors.purpleAccent,
        ),
      )
      : ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 80.0),
        children: [
          AirQualityPanel(
            index: forecast.airQuality,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: UVIndexPanel(
                      index: forecast.uvi,
                    )
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: DaylightPanel(
                      sunrise: forecast.sunrise,
                      sunset: forecast.sunset,
                    )
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: FeelsLikePanel(
                      feelsLike: forecast.feelsLike,
                      temperature: forecast.temperature,
                    )
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: HumidyPanel(
                      humidity: forecast.humidity,
                      dewPoint: forecast.dewPoint
                    )
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: VisibilityPanel(visibility: forecast.visibility)
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: PrecipitationPanel(
                      rain: forecast.rain,
                      snow: forecast.snow,
                    )
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: WindPanel(
                      speed: forecast.windSpeed,
                      angle: forecast.windAngle
                    )
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: PressurePanel(pressure: forecast.pressure)
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2F2F55),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.white),
            label: 'List',
          )
        ]
      )
    );
  }
}