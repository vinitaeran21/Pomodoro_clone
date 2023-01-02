import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FocusTimer extends StatelessWidget {
  final String pageTitle;
  final Color pageColor;
  final int timerLength;

  FocusTimer(
      {required this.pageTitle,
      required this.pageColor,
      required this.timerLength});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          '$pageTitle',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.cancel))
        ],
      ),
      body: Stack(children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              radiusFactor: 0.7,
              ranges: [
                GaugeRange(
                    startValue: 0,
                    endValue: 10,
                    color: Colors.red,
                    startWidth: 4,
                    endWidth: 4),
                GaugeRange(
                    startValue: 10,
                    endValue: 25 * 60,
                    color: pageColor,
                    startWidth: 4,
                    endWidth: 4),
              ],
              centerX: 0.5,
              centerY: 0.4,
              showTicks: false,
              showLabels: false,
              minimum: 0,
              maximum: 25 * 60,
              startAngle: 0,
              endAngle: 360,
            ),
          ],
        ),
        Align(
          alignment: Alignment(0, -0.4),
          child: Container(
            height: 32,
            width: 96,
            decoration: BoxDecoration(
                color: Color(0xFFC5C5C5),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                'Pomodoro',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, -0.15),
          child: Text(
            '00:59',
            style: TextStyle(color: Colors.white, fontSize: 64),
          ),
        )
      ]),
      bottomNavigationBar: Row(
        children: [
          IconButton(onPressed: onPressed, icon: Icon(Icons.dehaze_outlined)),
        ],
      ),
    );
  }
}
