import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/location/location_page.dart';
import 'package:weather_app/services/geolocation.dart';
import 'package:weather_app/services/weather_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool loading = false;
  List<LocationModel> locations = [];

  Future<void> getPosition() async {
    Position? position = await getCurrentPosition();

    if (position != null) {
      getLocation(position.latitude, position.longitude);
    }
  }

  Future<void> listLocations(String query) async {
    List<LocationModel> l = await searchLocations(query);

    setState(() {
      locations = l;
    });
  }

  Future<void> getLocation(double lat, double lon) async {
    setState(() {
      loading = true;
    });

    getLocationByLatLon(lat, lon).then((LocationModel l) {
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
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        onPressed: getPosition,
        child: const Icon(Icons.gps_fixed),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.list, color: Colors.white, size: 32)
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        children: [
          TextField(
            cursorColor: Colors.white,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white
            ),
            onChanged: (String value) {
              if (value.length < 4) {
                setState(() {
                  locations = [];
                });
              } else {
                listLocations(value);
              }
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              filled: true,
              fillColor: Colors.white24,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
              hintText: 'Search city',
              hintStyle: const TextStyle(
                color: Colors.white
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: getPosition,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8.0)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gps_fixed),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Current location'),
                  )
                ],
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:
            loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  LocationModel location = locations[index];
            
                  return ListTile(
                    onTap: () => getLocation(location.latitude!, location.longitude!),
                    tileColor: Colors.white24,
                    title: Text(
                      location.city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    subtitle: Text(
                      '${location.region} - ${location.country}',
                      style: const TextStyle(
                        color: Colors.white60
                      )
                    ),
                  );
                }
              ),
          )
        ],
      ),
    );
  }
}