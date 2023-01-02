import 'package:flutter/material.dart';
import 'package:practice123455/pomodoro_provider.dart';
import 'package:practice123455/screens/focus.dart';
import 'package:provider/provider.dart';

class Timings extends StatefulWidget {
  const Timings({Key? key}) : super(key: key);
  static String routename = 'timings';

  @override
  State<Timings> createState() => _TimingsState();
}

class _TimingsState extends State<Timings> {
  @override
  Widget build(BuildContext context) {
    final timerId = ModalRoute.of(context)!.settings.arguments as DateTime;
    final timerData = Provider.of<PomodoroProvider>(context).findById(timerId);
    PageController controller = PageController(initialPage: 0);
    return SafeArea(
      child: Scaffold(
        body: PageView(controller: controller, children: [
          FocusTimer(
              pageColor: Colors.yellow,
              pageTitle: 'Focus',
              timerLength: timerData.focus),
          FocusTimer(
            pageColor: Colors.green,
            pageTitle: 'Short Break',
            timerLength: timerData.shortbreak,
          ),
          FocusTimer(
            pageColor: Colors.blue,
            pageTitle: 'Long Break',
            timerLength: timerData.longbreak,
          )
        ]),
      ),
    );
  }
}
