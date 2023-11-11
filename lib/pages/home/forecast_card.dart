import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String time;
  final int temperature;
  final bool selected;

  const ForecastCard({super.key, required this.time, required this.temperature, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 125.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: selected
          ? Colors.indigo.shade800
          : Colors.indigo.shade400,
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            color: Colors.grey.shade700,
            blurRadius: 4.0
          )
        ],
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
          const Icon(Icons.cloud, color: Colors.white,),
          Text('$temperatureº', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}