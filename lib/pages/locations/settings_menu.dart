import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings/bloc.dart';
import 'package:weather_app/bloc/settings/state.dart';
import 'package:weather_app/enums/units.dart';
import 'package:weather_app/services/storage.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  List<Map<String, dynamic>> _options() => [
    {'unit': Units.celsius, 'name': 'Celsius', 'symbol': 'ºC'},
    {'unit': Units.fahrenheint, 'name': 'Fahrenheit', 'symbol': 'ºF'},
  ];

  void updateUnit(BuildContext context, Units unit) {
    StorageManager().updateAppUnit(unit).whenComplete(() {
      context.read<SettingsBloc>().updateUnit(unit);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsBlocState>(
      builder: (BuildContext context, SettingsBlocState state) {
        return PopupMenuButton(
          color: Colors.indigo.withOpacity(0.6),
          itemBuilder: (BuildContext context) {
            return _options().map((Map<String, dynamic> option) {
              return PopupMenuItem(
                child: ListTile(
                  onTap: () => updateUnit(context, option['unit']),
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 2,
                  leading: SizedBox(
                    width: 20,
                    child: option['unit'] == state.unit ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                  title: SizedBox(
                    width: 100,
                    child: Text(
                      option['name'],
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                  trailing: Text(
                    option['symbol'],
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
              );
            }).toList();
          },
          child: const Icon(Icons.settings),
        );
      }
    );
  }
}