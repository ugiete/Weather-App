import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/enums/condition.dart';

class WeatherIcon extends StatelessWidget {
  final bool isDay;
  final Condition condition;
  final Color color;

  const WeatherIcon({super.key, required this.isDay, required this.condition, required this.color});

  IconData _icon() {
    switch (condition) {
      case Condition.clear:
        return isDay ? Icons.sunny : CupertinoIcons.moon_stars_fill;
      
      case Condition.partlyCloudy:
      case Condition.overcast:
        return isDay ? CupertinoIcons.cloud_sun_fill : CupertinoIcons.cloud_moon_fill;

      case Condition.cloudy:
        return Icons.cloud;

      case Condition.mist:
      case Condition.fog:
      case Condition.freezingFog:
        return isDay ? CupertinoIcons.sun_haze_fill : CupertinoIcons.cloud_moon_fill;
      
      case Condition.patchyRainPossible:
      case Condition.patchyFreezingDrizzlePossible:
      case Condition.patchyLightDrizzle:
      case Condition.patchyLightRain:
      case Condition.lightFreezingRain:
      case Condition.lightRainShower:
        return isDay ? CupertinoIcons.cloud_sun_rain_fill : CupertinoIcons.cloud_moon_rain_fill;
      
      case Condition.patchySnowPossible:
      case Condition.patchySleetPossible:
      case Condition.lightSleet:
      case Condition.lightSleetShower:
      case Condition.moderateSleetShower:
        return Icons.snowing;

      case Condition.thunderyOutbreaksPossible:
      case Condition.torrentialRainShower:
      case Condition.patchyLightRainThunder:
      case Condition.moderateLightRainThunder:
      case Condition.patchyLightSnowThunder:
      case Condition.moderateSnowThunder:
        return Icons.thunderstorm;

      case Condition.blowingSnow:
        return CupertinoIcons.wind_snow;

      case Condition.blizzard:
      case Condition.heavySnow:
      case Condition.icePellets:
      case Condition.moderateIcePelletsShower:
        return CupertinoIcons.snow;

      case Condition.heavyFreezingDrizzle:
      case Condition.moderateRainTimes:
      case Condition.moderateRain:
      case Condition.heavyRainTimes:
      case Condition.heavyRain:
      case Condition.moderateFreezingRainTimes:
      case Condition.moderateRainShower:
        return CupertinoIcons.cloud_rain_fill;

      case Condition.moderateFreezingSleet:
      case Condition.lightSnow:
      case Condition.moderateSnow:
      case Condition.patchyHeavySnow:
      case Condition.moderateSnowShower:
      case Condition.lightIcePelletsShower:
        return CupertinoIcons.cloud_snow_fill;

      case Condition.patchyModerateSnow:
      case Condition.patchyLightSnow:
      case Condition.lightSnowShower:
        return isDay ? Icons.sunny_snowing : CupertinoIcons.cloud_snow_fill;

      default:
        return isDay ? Icons.sunny : CupertinoIcons.moon_fill;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon(),
      color: color,
    );
  }
}