import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/pages/locations/locations_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

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
    debugPrint(coord.latitude.toString());
    debugPrint(coord.longitude.toString());
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
          onTap: (TapPosition position, LatLng coord) => addLocation(coord),
          initialCenter: const LatLng(51.5, -0.09),
          initialZoom: 5
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