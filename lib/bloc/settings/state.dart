import 'package:weather_app/enums/units.dart';
import 'package:weather_app/model/location.dart';

class SettingsBlocState {
  LocationModel? defaultLocation;
  Units unit;

  SettingsBlocState(this.defaultLocation, this.unit);

  factory SettingsBlocState.clone(SettingsBlocState other) {
    return SettingsBlocState(other.defaultLocation, other.unit);
  }
}