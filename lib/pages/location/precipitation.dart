import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrecipitationPanel extends StatelessWidget {
  final int rain;
  final int snow;

  const PrecipitationPanel({super.key, required this.rain, required this.snow});

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
              Icon(
                snow > 0
                  ? CupertinoIcons.snow
                  : Icons.water_drop,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'PRECIPITATION',
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
              '${snow > 0 ? snow : rain} mm',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'In the last hour',
              style: TextStyle(
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