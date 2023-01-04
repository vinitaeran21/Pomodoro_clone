import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:practice123455/modelss/pomodoromodel.dart';

class PomodoroProvider with ChangeNotifier {
  List<Pomodoro> _timerList = [
    Pomodoro(
        id: DateTime.now(),
        focus: 25,
        shortbreak: 5,
        longbreak: 15,
        roundsForLongBreak: 4,
        title: 'Pomodoro',
        icon: '🍅')
  ];

  List<Pomodoro> get timers {
    return [..._timerList];
  }

  Pomodoro findById(DateTime id) {
    return _timerList.firstWhere((element) => element.id == id);
  }

  void addPomodoro(Pomodoro newPomodoro) {
    _timerList.add(newPomodoro);
    notifyListeners();
  }
}
