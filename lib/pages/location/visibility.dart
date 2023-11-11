import 'package:flutter/material.dart';

class VisibilityPanel extends StatelessWidget {
  final int visibility;

  const VisibilityPanel({super.key, required this.visibility});

  String _range() {
    return visibility < 1000
      ? '$visibility m'
      : '${(visibility / 1000).floor()} km';
  }

  String _condition() {
    if (visibility < 50) {
      return 'Dense fog';
    } else if (visibility < 200) {
      return 'Thick fog';
    } else if (visibility < 500) {
      return 'Moderate fog';
    } else if (visibility < 1000) {
      return 'Light fog';
    } else if (visibility < 2000) {
      return 'Thin fog';
    } else if (visibility < 4000) {
      return 'Haze';
    } else if (visibility < 10000) {
      return 'Light haze';
    } else if (visibility < 20000) {
      return 'Clear';
    } else if (visibility < 50000) {
      return 'Very clear';
    } else if (visibility >= 277000) {
      return 'Pure Air';
    } else {
      return 'Exceptionally clear';
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
                Icons.visibility,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'VISIBILITY',
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
              _range(),
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
              '${_condition()} right now',
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