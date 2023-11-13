import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/locations/locations_page.dart';
import 'package:weather_app/services/database.dart';
import 'package:weather_app/services/geolocation.dart';

class ControllerBottomBar extends StatelessWidget {
  const ControllerBottomBar({super.key});

  Future<void> getPosition() async {
    Position? position = await getCurrentPosition();

    LocationModel location = LocationModel(null, 'Victoria', 'British Columbia', 'Canada', position?.latitude, position?.longitude);

    await DatabaseManager().addLocation(location, null);
  }

  Future<void> listLocations(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LocationsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const ThreePointCubic curve = Curves.fastEaseInToSlowEaseOut;
          CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

          return ScaleTransition(scale: curvedAnimation, child: child);
        }
      )
    );
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