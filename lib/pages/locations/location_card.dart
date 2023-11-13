import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/location/location_page.dart';
import 'package:weather_app/services/storage.dart';

class LocationCard extends StatelessWidget {
  final void Function() onDelete;
  final LocationModel location;
  final bool isDefault;
  
  const LocationCard({super.key, required this.location, required this.onDelete, required this.isDefault});

  void saveDefaultLocation(BuildContext context) {
    StorageManager().updateDefaultLocation(location);
  }

  void openLocation(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LocationPage(location: location),
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
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          if (!isDefault)
            SlidableAction(
              onPressed: saveDefaultLocation,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.star
            ),
          SlidableAction(
            onPressed: (BuildContext context) => onDelete(),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete
          )
        ]
      ),
      child: GestureDetector(
        onTap: () => openLocation(context),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            color: Colors.indigo
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          location.city,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Text(
                          '10:47 AM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                          )
                        )
                      ],
                    ),
                    const Text(
                      '2º',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ensolarado',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    Text(
                      'H: 7º L: -1º',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}