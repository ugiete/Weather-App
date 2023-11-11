import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HumidyPanel extends StatelessWidget {
  final int humidity;
  final int dewPoint;

  const HumidyPanel({super.key, required this.humidity, required this.dewPoint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurpleAccent.shade100),
        color: Colors.indigo
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.speed,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'HUMIDITY',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              '$humidity%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'The dew point right now is $dewPointº',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12
              ),
            ),
          ),
        ],
      ),
    );
  }
}