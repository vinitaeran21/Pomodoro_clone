import 'package:flutter/material.dart';
import 'package:practice123455/screens/timings_screen.dart';
import '../modelss/pomodoromodel.dart';
import '../screens/add_new_timer_screen.dart';

class TimerCard extends StatelessWidget {
  Pomodoro data;

  TimerCard({super.key, required this.data});
  static String routename = 'timingscreen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(Timings.routename, arguments: data.id),
      child: Container(
        padding: const EdgeInsets.only(left: 6, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                  color: Colors.black26)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(data.icon),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16))),
                        context: context,
                        builder: (context) => AddPomodoroSheet(
                              editingPomodoro: data,
                            ));
                  },
                  icon: const Icon(Icons.more_horiz))
            ]),
            const Spacer(),
            Text(
              '${data.focus} min',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              data.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
