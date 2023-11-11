import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PressurePanel extends StatelessWidget {
  final int pressure;

  const PressurePanel({super.key, required this.pressure});

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
                Icons.download,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'PRESSURE',
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
                      showLabels: false,
                      minimum: 950,
                      maximum: 1100,
                      minorTicksPerInterval: 9,
                      showAxisLine: false,
                      radiusFactor: 1.3,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 950,
                            endValue: pressure.toDouble(),
                            startWidth: 0.1,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.1,
                            color: Colors.purpleAccent),
                        GaugeRange(
                            startValue: pressure.toDouble(),
                            endValue: 1100,
                            startWidth: 0.1,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.1,
                            color: Colors.indigo.shade300),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0.15,
                          widget: Text(
                            pressure.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )
                          )
                        ),
                        const GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0.6,
                          widget: Text(
                            'hPa',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                      pointers: <GaugePointer>[
                        MarkerPointer(
                          color: Colors.white,
                          value: pressure.toDouble(),
                        )
                      ],
                      axisLabelStyle: const GaugeTextStyle(fontSize: 12),
                      majorTickStyle: const MajorTickStyle(
                          length: 0.25, lengthUnit: GaugeSizeUnit.factor),
                      minorTickStyle: const MinorTickStyle(
                          length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}