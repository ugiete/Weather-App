import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings/events.dart';
import 'package:weather_app/bloc/settings/state.dart';
import 'package:weather_app/enums/units.dart';
import 'package:weather_app/model/location.dart';

class SettingsBloc extends Bloc<SettingsBlocEvent, SettingsBlocState> {
  SettingsBloc(SettingsBlocState initialState) : super(initialState) {
    on<UpdateEvent>((event, emit) => emit(SettingsBlocState(event.state.defaultLocation, event.state.unit)));
  }

  void updateLocation(LocationModel? location) {
    SettingsBlocState newState = SettingsBlocState.clone(state);

    newState.defaultLocation = location;

    add(UpdateEvent(newState));
  }

  void updateUnit(Units unit) {
    SettingsBlocState newState = SettingsBlocState.clone(state);

    newState.unit = unit;

    add(UpdateEvent(newState));
  }
}