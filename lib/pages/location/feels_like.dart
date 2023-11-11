import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelsLikePanel extends StatelessWidget {
  final int temperature;
  final int feelsLike;

  const FeelsLikePanel({super.key, required this.temperature, required this.feelsLike});

  String _disclaimer() {
    if (feelsLike < temperature) {
      return 'Feeling colder than real temperature';
    } else if (feelsLike > temperature) {
      return 'Feeling warmer than real temperature';
    } else {
      return 'Feeling similar to real temperature';
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
                CupertinoIcons.thermometer,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'FEELS LIKE',
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
              '$feelsLikeº',
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
              _disclaimer(),
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