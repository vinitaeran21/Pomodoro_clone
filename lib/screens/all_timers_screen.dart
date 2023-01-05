import 'package:flutter/material.dart';
import 'package:practice123455/modelss/pomodoromodel.dart';
import 'package:practice123455/pomodoro_provider.dart';
import 'package:practice123455/widgets/all_timers_grid.dart';
import 'package:practice123455/widgets/timercard.dart';
import 'package:provider/provider.dart';

import 'add_new_timer_screen.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);
  static String routename = 'timerscreen';

  @override
  Widget build(BuildContext context) {
    final timerData = Provider.of<PomodoroProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Timers'),
          actions: [
            IconButton(
                onPressed: () {
                  timerData.addPomodoro();
                },
                icon: Icon(
                  Icons.add,
                ))
          ],
        ),
        body: TimersGrid());
  }
}
