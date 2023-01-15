import 'package:flutter/material.dart';
import 'package:practice123455/providers/pomodoro_provider.dart';
import 'package:practice123455/widgets/all_timers_grid.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);
  static String routename = 'timerscreen';

  @override
  Widget build(BuildContext context) {
    final timerData = Provider.of<PomodoroProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Timers'),
          actions: [
            IconButton(
                onPressed: () {
                  timerData.addPomodoro();
                },
                icon: const Icon(
                  Icons.add,
                ))
          ],
        ),
        body: const TimersGrid());
  }
}
