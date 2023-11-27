import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings/events.dart';
import 'package:weather_app/bloc/settings/state.dart';
import 'package:weather_app/enums/units.dart';

class SettingsBloc extends Bloc<SettingsBlocEvent, SettingsBlocState> {
  SettingsBloc(SettingsBlocState initialState) : super(initialState) {
    on<UpdateUnitEvent>((event, emit) => emit(SettingsBlocState(event.unit)));
  }

  void updateUnit(Units unit) {
    add(UpdateUnitEvent(unit));
  }
}