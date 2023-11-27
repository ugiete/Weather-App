import 'package:weather_app/enums/units.dart';

abstract class SettingsBlocEvent {}

class UpdateUnitEvent extends SettingsBlocEvent {
  final Units unit;

  UpdateUnitEvent(this.unit);
}