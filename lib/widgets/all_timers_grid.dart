import 'package:flutter/material.dart';
import 'package:practice123455/widgets/timercard.dart';
import 'package:provider/provider.dart';

import '../providers/pomodoro_provider.dart';

class TimersGrid extends StatelessWidget {
  const TimersGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerData = Provider.of<PomodoroProvider>(context, listen: true);
    final timerList = timerData.timers;
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.6,
        ),
        itemCount: timerList.length,
        itemBuilder: (ctx, i) {
          return TimerCard(
            data: timerList[i],
          );
        });
  }
}
