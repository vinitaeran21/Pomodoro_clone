import 'package:flutter/material.dart';
import 'package:practice123455/screens/timings.dart';
import 'package:provider/provider.dart';

import '../modelss/pomodoromodel.dart';

class TimerCard extends StatelessWidget {
  Pomodoro data;

  TimerCard({required this.data});
  static String routename = 'timingscreen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(Timings.routename, arguments: data.id),
      child: Container(
        padding: EdgeInsets.only(left: 6, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                  color: Colors.black26)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.dehaze_outlined))
            ]),
            Spacer(),
            Text(
              '${data.focus} min',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
