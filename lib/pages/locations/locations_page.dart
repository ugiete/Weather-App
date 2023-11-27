import 'package:flutter/material.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/locations/location_card.dart';
import 'package:weather_app/pages/locations/settings_menu.dart';
import 'package:weather_app/pages/search/search_page.dart';
import 'package:weather_app/services/database.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  void searchLocations() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(),
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
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: SettingsMenu()
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Locations',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onTap: searchLocations,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white24,
                ),
                child: const Row(
                  children: [
                     Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Search city',
                        style: TextStyle(
                          color: Colors.white
                        )
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FutureBuilder<List<LocationModel>>(
              future: DatabaseManager().listLocations(),
              builder: (BuildContext context, AsyncSnapshot<List<LocationModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: LocationCard(
                          isDefault: false,
                          location: snapshot.data![index],
                          onDelete: () {
                            DatabaseManager().deleteLocation(snapshot.data![index]).whenComplete(() {
                              setState(() {});
                            });
                          },
                        ),
                      );
                    }
                  );
                }
          
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}