import 'package:weather_app/bloc/settings/state.dart';

abstract class SettingsBlocEvent {}

class UpdateEvent extends SettingsBlocEvent {
  final SettingsBlocState state;

  UpdateEvent(this.state);
}