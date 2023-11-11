import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WindPanel extends StatelessWidget {
  final int speed;
  final int angle;

  const WindPanel({super.key, required this.speed, required this.angle});

  void _handleLabelCreated(AxisLabelCreatedArgs args) {
    Color color = Colors.indigo.shade900;
    FontWeight fontWeight = FontWeight.normal;

    if (args.text == '0' || args.text == '360') {
      args.text = 'N';
      
      if (angle < 22.5 || angle >= 337.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '45') {
      args.text = 'NE';

      if (angle >= 22.5 && angle < 67.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '90') {
      args.text = 'E';

      if (angle >= 67.5 && angle < 112.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '135') {
      args.text = 'SE';

      if (angle >= 112.5 && angle < 157.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '180') {
      args.text = 'S';

      if (angle >= 157.5 && angle < 202.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '225') {
      args.text = 'SW';

      if (angle >= 202.5 && angle < 247.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '270') {
      args.text = 'W';

      if (angle >= 247.5 && angle < 292.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else if (args.text == '315') {
      args.text = 'NW';

      if (angle >= 292.5 && angle < 337.5) {
        color = Colors.white;
        fontWeight = FontWeight.bold;
      }

    } else {
      args.text = '';
    }

    args.labelStyle = GaugeTextStyle(
      color: color,
      fontWeight: fontWeight
    );
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
                Icons.air,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'WIND',
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
            padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
            child: SizedBox.fromSize(
              size: const Size.fromHeight(100),
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    startAngle: 270,
                    endAngle: 270,
                    radiusFactor: 1.3,
                    maximum: 360,
                    axisLineStyle: AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: Colors.indigo.shade300,
                      thickness: 0.1
                    ),
                    interval: 45,
                    canRotateLabels: false,
                    axisLabelStyle: const GaugeTextStyle(),
                    minorTicksPerInterval: 0,
                    majorTickStyle: MajorTickStyle(
                      lengthUnit: GaugeSizeUnit.factor,
                      color: Colors.indigo.shade900,
                      length: 0.07
                    ),
                    onLabelCreated: _handleLabelCreated,
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: angle.toDouble(),
                        markerHeight: 15,
                        markerWidth: 15,
                        color: Colors.white,
                        markerType: MarkerType.triangle,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        angle: 90,
                        widget: Text(
                          speed.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          )
                        )
                      ),
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.3,
                        widget: Text(
                          'km/h',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          )
                        )
                      )
                    ]
                  )
                ],
              )
            )
          )
        ],
      ),
    );
  }
}