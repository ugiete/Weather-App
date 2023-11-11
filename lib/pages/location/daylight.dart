import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaylightPanel extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const DaylightPanel({super.key, required this.sunrise, required this.sunset});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isDay = now.isAfter(sunrise) && now.isBefore(sunset);
    DateFormat formatter = DateFormat('h:mm a');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurpleAccent.shade100),
        color: Colors.indigo
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Icon(
                  isDay ? CupertinoIcons.sunset_fill: CupertinoIcons.sunrise_fill,
                  color: Colors.grey,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    isDay ? 'SUNSET': 'SUNRISE',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              formatter.format(isDay ? sunset : sunrise),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 28
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CustomPaint(
              size: const Size.fromHeight(40),
              painter: DaylightWave(
                ratio: 0.45
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                isDay
                  ? 'Sunrise: ${formatter.format(sunrise)}'
                  : 'Sunset: ${formatter.format(sunset)}',
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DaylightWave extends CustomPainter {
  final double ratio;

  DaylightWave({super.repaint, required this.ratio});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.indigo.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    
    double width = size.width;
    double height = size.height;

    Path path = Path();

    path.moveTo(0, height * 0.75);
    path.quadraticBezierTo(width * 0.1, height, width * 0.3, height * ratio);
    path.moveTo(width * 0.7, height * ratio);
    path.quadraticBezierTo(width * 0.9, height, width, height * 0.75);

    canvas.drawPath(path, paint);

    paint = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    path = Path();

    path.moveTo(width * 0.3, height * ratio);
    path.quadraticBezierTo(width * 0.42, 0.0, width * 0.5, 0.0);
    path.quadraticBezierTo(width * 0.58, 0.0, width * 0.7, height * ratio);

    canvas.drawPath(path, paint);

    paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    path = Path();

    path.moveTo(0, height * ratio);
    path.lineTo(width, height * ratio);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}