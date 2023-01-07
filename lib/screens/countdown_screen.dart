import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class FocusTimer extends StatelessWidget {
  final String pageTitle;
  final Color ringColor;
  final int timerLength;
  final CountDownController controller;
  final Function lapUpdate;
  final String timerTitle;

  FocusTimer(
      {required this.pageTitle,
      required this.ringColor,
      required this.timerLength,
      required this.controller,
      required this.lapUpdate,
      required this.timerTitle});

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
              onPressed: () {
                controller.isStarted
                    ? controller.isPaused
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
            onComplete: () {
              print('im here 3');
              if (!controller.isRestarted) lapUpdate();
            },
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
            controller: controller,
            autoStart: false,
            initialDuration: 0,
            duration: timerLength * 60,
            fillColor: Colors.black,
            ringColor: ringColor,
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
                  timerTitle,
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
