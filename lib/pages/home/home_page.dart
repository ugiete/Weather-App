import 'package:flutter/material.dart';
import 'package:weather_app/model/location.dart';
import 'package:weather_app/pages/home/forecast_card.dart';
import 'package:weather_app/pages/home/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final LocationModel location;

  const HomePage({super.key, required this.location});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime now = DateTime.now();
  ScrollController hourlyController = ScrollController();
  ScrollController weeklyController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      hourlyController.jumpTo(now.hour * 60.0);
      hourlyController.jumpTo((now.weekday % 7) * 60.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F55),
      body: Container(
        decoration: const BoxDecoration(),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.location.city,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white
                      ),
                    ),
                    const Text(
                      '19º',
                      style: TextStyle(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.w200
                      ),
                    ),
                    const Text(
                      'Mostly Clear',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'H:24º L:18º',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.shade800,
                        Colors.indigo.shade400
                      ]
                    )
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return states.contains(MaterialState.focused) ? null : Colors.transparent;
                            }
                          ),
                          indicatorSize: TabBarIndicatorSize.label, 
                          tabs: const [
                            Tab(text: 'Hourly Forecast', ),
                            Tab(text: 'Weekly Forecast',)
                          ]
                        ),
                        Flexible(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0),
                                child: ListView.builder(
                                  controller: hourlyController,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(right: 10.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 24,
                                  itemBuilder: (BuildContext context, int index) {
                                    String hour = index < 12
                                      ? '$index AM'
                                      : '${index == 12 ? index : index - 12} PM';

                                    return Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: ForecastCard(
                                        time: hour,
                                        temperature: 5,
                                        selected: index == now.hour
                                      ),
                                    );
                                  }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0),
                                child: ListView(
                                  controller: weeklyController,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(right: 10.0),
                                  scrollDirection: Axis.horizontal,
                                  children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'].asMap().entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: ForecastCard(
                                        time: entry.value,
                                        temperature: 0,
                                        selected: (now.weekday % 7) == entry.key,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ControllerBottomBar(),
    );
  }
}