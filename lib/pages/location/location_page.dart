import 'package:flutter/material.dart';
import 'package:weather_app/pages/location/air_quality.dart';
import 'package:weather_app/pages/location/daylight.dart';
import 'package:weather_app/pages/location/feels_like.dart';
import 'package:weather_app/pages/location/humidity.dart';
import 'package:weather_app/pages/location/precipitation.dart';
import 'package:weather_app/pages/location/pressure.dart';
import 'package:weather_app/pages/location/uv_index.dart';
import 'package:weather_app/pages/location/visibility.dart';
import 'package:weather_app/pages/location/wind.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Edmonton',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white
                ),
              ),
              Text(
                '19º | Mostly Clear',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),
              )
            ],
          ),
        )
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
        children: [
          const AirQualityPanel(
            index: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  const Flexible(
                    child: UVIndexPanel(
                      index: 2,
                    )
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: DaylightPanel(
                      sunrise: DateTime(2023, 11, 11, 4, 43),
                      sunset: DateTime(2023, 11, 11, 19, 54),
                    )
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: FeelsLikePanel(
                      feelsLike: 2,
                      temperature: 2,
                    )
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: HumidyPanel(
                      humidity: 55,
                      dewPoint: -3
                    )
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: VisibilityPanel(visibility: 100)
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: PrecipitationPanel(
                      rain: 0,
                      snow: 10,
                    )
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    child: WindPanel(
                      speed: 3,
                      angle: 218
                    )
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: PressurePanel(pressure: 1014)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}