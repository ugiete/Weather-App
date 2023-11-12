import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/geolocation.dart';

class ControllerBottomBar extends StatelessWidget {
  const ControllerBottomBar({super.key});

  Future<void> getPosition() async {
    getCurrentPosition()
      .then((Position position) {
        debugPrint(position.latitude.toString());
        debugPrint(position.longitude.toString());
      })
      .onError((error, stackTrace) {
        debugPrint(error.toString());
      });
  }

  void listLocations(BuildContext context) {
    //
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.indigo,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 15.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: getPosition,
              child: const Icon(Icons.gps_fixed, color: Colors.white, size: 32)
            ),
            GestureDetector(
              onTap: () => listLocations(context),
              child: const Icon(Icons.list, color: Colors.white, size: 32)
            )
          ],
        ),
      ),
    );
  }
}