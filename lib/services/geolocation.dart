import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error(404);
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error(401);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(403);
  }

  return await Geolocator.getCurrentPosition();
}