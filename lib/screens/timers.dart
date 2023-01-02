import 'package:flutter/material.dart';
import 'package:practice123455/pomodoro_provider.dart';
import 'package:practice123455/widgets/timercard.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);
  static String routename = 'timerscreen';

  @override
  Widget build(BuildContext context) {
    final timerData = Provider.of<PomodoroProvider>(context);
    final timerList = timerData.timers;
    return Scaffold(
        appBar: AppBar(
          title: Text('Timers'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                ))
          ],
        ),
        body: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.6,
            ),
            itemCount: PomodoroProvider().timers.length,
            itemBuilder: (ctx, i) {
              return TimerCard(
                data: timerList[i],
              );
            }));
  }
}
