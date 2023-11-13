import 'package:flutter/material.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/locations/location_card.dart';
import 'package:weather_app/services/database.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: PopupMenuButton(
              color: Colors.indigo.withOpacity(0.6),
              itemBuilder: (BuildContext context) {
                List<Map<String, dynamic>> options = [
                  {'selected': true, 'unit': 'Celsius', 'symbol': 'ºC'},
                  {'selected': false, 'unit': 'Fahrenheit', 'symbol': 'ºF'},
                ];

                return options.map((Map<String, dynamic> option) {
                  return PopupMenuItem(
                    child: ListTile(
                      onTap: () {

                      },
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 2,
                      leading: SizedBox(
                        width: 20,
                        child: option['selected'] ? const Icon(Icons.check, color: Colors.white) : null,
                      ),
                      title: SizedBox(
                        width: 100,
                        child: Text(
                          option['unit'],
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
            ),
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
            child: TextField(
              cursorColor: Colors.white,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
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
                  borderRadius: BorderRadius.circular(20.0)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
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