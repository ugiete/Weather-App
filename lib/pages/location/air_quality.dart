import 'package:flutter/material.dart';

class AirQualityPanel extends StatelessWidget {
  final int index;

  const AirQualityPanel({super.key, required this.index});

  String _category() {
    if (index <= 3) {
      return 'Low';
    } else if (index <= 6) {
      return 'Moderate';
    } else if (index < 10) {
      return 'High';
    } else {
      return 'Extreme';
    }
  }

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
                Icons.snowing,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'AIR QUALITY',
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
              '$index-${_category()} Health Risk',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.purpleAccent,
              backgroundColor: Colors.indigo.shade300,
              value: index/10,
            ),
          )
        ],
      ),
    );
  }
}