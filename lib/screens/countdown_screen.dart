import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class FocusTimer extends StatefulWidget {
  final String pageTitle;
  final Color ringColor;
  final int timerLength;
  final CountDownController controller;

  FocusTimer(
      {required this.pageTitle,
      required this.ringColor,
      required this.timerLength,
      required this.controller});

  @override
  State<FocusTimer> createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          '${widget.pageTitle}',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                widget.controller.isStarted
                    ? widget.controller.isPaused
                        ? Navigator.of(context).pop()
                        : null
                    : Navigator.of(context).pop();
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      body: Stack(children: [
        Align(
          alignment: Alignment(0, -0.3),
          child: CircularCountDownTimer(
            textStyle: const TextStyle(
              fontSize: 64,
              letterSpacing: 3,
              color: Colors.white,
            ),
            isReverse: true,
            isReverseAnimation: false,
            textFormat: CountdownTextFormat.MM_SS,
            isTimerTextShown: true,
            strokeWidth: 6,
            controller: widget.controller,
            autoStart: false,
            initialDuration: 0,
            duration: widget.timerLength * 60,
            fillColor: Colors.black,
            ringColor: widget.ringColor,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
        Align(
            alignment: Alignment(0, -0.4),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffb2b2b2)),
              width: MediaQuery.of(context).size.width * 0.3,
              child: Center(
                child: Text(
                  'Pomodoro',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ))
      ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
