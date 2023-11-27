import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/location/location_page.dart';
import 'package:weather_app/pages/locations/locations_page.dart';
import 'package:weather_app/services/weather_api.dart';

class MapPage extends StatefulWidget {
  final double lat;
  final double lon;

  const MapPage({super.key, this.lat = 0.0, this.lon = 0.0});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController controller = MapController();

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

  Future<void> addLocation(LatLng coord) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    getLocationByLatLon(coord.latitude, coord.longitude).then((LocationModel l) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LocationPage(location: l),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const ThreePointCubic curve = Curves.fastEaseInToSlowEaseOut;
            CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

            return ScaleTransition(scale: curvedAnimation, child: child);
          }
        )
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo.withOpacity(0.6),
        leading: GestureDetector(
          onTap: () => listLocations(context),
          child: const Icon(Icons.list, color: Colors.white, size: 32)
        ),
      ),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
          maxZoom: 12,
          minZoom: 5,
          onTap: (TapPosition position, LatLng coord) => addLocation(coord),
          initialCenter: LatLng(widget.lat, widget.lon),
          initialZoom: 12
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          )
        ]
      )
    );
  }
}