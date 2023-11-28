import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:timezone/standalone.dart';
import 'package:weather_app/bloc/settings/bloc.dart';
import 'package:weather_app/bloc/settings/state.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/location/location_page.dart';
import 'package:weather_app/services/storage.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/utils/weather_icon.dart';

class LocationCard extends StatefulWidget {
  final void Function() onDelete;
  final LocationModel location;
  final bool isDefault;
  
  const LocationCard({super.key, required this.location, required this.onDelete, required this.isDefault});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  bool loading = true;
  late ForecastModel forecast;

  void saveDefaultLocation(BuildContext context) {
    context.read<SettingsBloc>().updateLocation(widget.location);
    StorageManager().updateDefaultLocation(widget.location);
  }

  void removeDefaultLocation(BuildContext context) {
    context.read<SettingsBloc>().updateLocation(null);
    StorageManager().deleteDefaultLocation();
  }

  void openLocation(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LocationPage(location: widget.location),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const ThreePointCubic curve = Curves.fastEaseInToSlowEaseOut;
          CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

          return ScaleTransition(scale: curvedAnimation, child: child);
        }
      )
    );
  }

  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: const Offset(0, 10))
  ];

  Future<void> loadForecast() async {
    ForecastModel f = await getForecastByLocation(widget.location, days: 1);

    setState(() {
      forecast = f;
      loading = false;
    });
  }

  @override
  void initState() {
    loadForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('h:mm a');
    Location? tzLocation = widget.location.timezone == null
      ? null
      : getLocation(widget.location.timezone!);

    return BlocBuilder<SettingsBloc, SettingsBlocState>(
      builder: (BuildContext context, SettingsBlocState state) {
        return Slidable(
          endActionPane: loading
            ? null
            : ActionPane(
              motion: const BehindMotion(),
              children: [
                widget.isDefault
                  ? SlidableAction(
                    onPressed: removeDefaultLocation,
                    backgroundColor: Colors.blue,
                    label: 'Unfav',
                    foregroundColor: Colors.white,
                    icon: Icons.star_border
                  )
                  : SlidableAction(
                    onPressed: saveDefaultLocation,
                    backgroundColor: Colors.blue,
                    label: 'Fav',
                    foregroundColor: Colors.white,
                    icon: Icons.star
                  ),
                SlidableAction(
                  onPressed: (BuildContext context) => widget.onDelete(),
                  backgroundColor: const Color(0xFFFE4A49),
                  label: 'Remove',
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.location.isFavorite)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Icon(Icons.star, color: Colors.white),
                                  ),
                                Text(
                                  widget.location.city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              tzLocation == null
                                ? ''
                                : formatter.format(TZDateTime.now(tzLocation)),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12
                              )
                            )
                          ],
                        ),
                        if(!loading)
                          Text(
                            '${forecast.current.temp(state.unit)}º',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500
                            )
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: loading
                      ? Align(
                        alignment: Alignment.centerLeft,
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(5.0),
                          shimmerColor: Colors.indigo.shade800,
                          child: SizedBox.fromSize(
                            size: const Size.fromHeight(20),
                          ),
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              WeatherIcon(
                                isDay: forecast.current.isDay,
                                condition: forecast.current.condition,
                                color: Colors.white
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  forecast.current.weather,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'H: ${forecast.daily[0].max(state.unit)}º L: ${forecast.daily[0].min(state.unit)}º',
                            style: const TextStyle(
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
    );
  }
}