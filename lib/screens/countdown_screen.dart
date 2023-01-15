import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:practice123455/providers/history_provider.dart';
import 'package:provider/provider.dart';

class FocusTimer extends StatefulWidget {
  final String pageTitle;
  final Color ringColor;
  final int timerLength;
  final CountDownController controller;
  final Function lapUpdate;
  final String timerTitle;
  final Function pauseAudio;

  const FocusTimer(
      {super.key,
      required this.pageTitle,
      required this.ringColor,
      required this.timerLength,
      required this.controller,
      required this.lapUpdate,
      required this.timerTitle,
      required this.pauseAudio});

  @override
  State<FocusTimer> createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final historyData = Provider.of<HistoryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          widget.pageTitle,
          style: const TextStyle(color: Colors.white),
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
              icon: const Icon(Icons.cancel))
        ],
      ),
      body: Stack(children: [
        Align(
          alignment: const Alignment(0, -0.3),
          child: CircularCountDownTimer(
            onComplete: () {
              widget.pauseAudio();
              historyData.addHistory(widget.timerTitle, DateTime.now(),
                  Duration(minutes: widget.timerLength), widget.pageTitle);
              widget.controller.reset();
              widget.lapUpdate();
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
            alignment: const Alignment(0, -0.4),
            child: TimerTitle(
              timerTitle: widget.timerTitle,
            ))
      ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TimerTitle extends StatelessWidget {
  const TimerTitle({
    Key? key,
    required this.timerTitle,
  }) : super(key: key);

  final String timerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      height: MediaQuery.of(context).size.width * 0.08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffb2b2b2)),
      width: MediaQuery.of(context).size.width * 0.3,
      child: Center(
        child: Text(
          overflow: TextOverflow.ellipsis,
          timerTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
