import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:practice123455/modelss/pomodoromodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PomodoroProvider with ChangeNotifier {
  List<Pomodoro> _timerList = [
    Pomodoro(
        id: Uuid().v4(),
        focus: 25,
        shortbreak: 5,
        longbreak: 15,
        laps: 4,
        title: 'Pomodoro',
        icon: '🍅')
  ];

  List<Pomodoro> get timers {
    // var prefs = await SharedPreferences.getInstance();
    // for (int i = 1;; i++) {
    //   if (prefs.containsKey('Pomo$i')) {
    //     List<String> pomoData = prefs.getStringList('Pomo$i')!;
    //     _timerList[i - 1] = Pomodoro(
    //         id: pomoData[0],
    //         focus: int.parse(pomoData[1]),
    //         shortbreak: int.parse(pomoData[2]),
    //         longbreak: int.parse(pomoData[3]),
    //         laps: int.parse(pomoData[4]),
    //         title: pomoData[5],
    //         icon: pomoData[6]);
    //   } else
    //     break;
    // }
    return [..._timerList];
  }

  Pomodoro findById(String id) {
    return _timerList.any((element) => element.id == id)
        ? _timerList.firstWhere((element) => element.id == id)
        : Pomodoro(
            id: id,
            focus: 25,
            shortbreak: 5,
            longbreak: 15,
            laps: 4,
            title: 'Pomodoro',
            icon: '🍅');
  }

  void addPomodoro() {
    _timerList.add(Pomodoro(
        id: Uuid().v4(),
        focus: 25,
        shortbreak: 5,
        longbreak: 15,
        laps: 4,
        title: 'Pomodoro',
        icon: '🍅'));
    notifyListeners();
  }

  void EditingPomodoro(Pomodoro updatedPomodoro) async {
    // var prefs = await SharedPreferences.getInstance();

    int i =
        _timerList.indexWhere((element) => element.id == updatedPomodoro.id);
    _timerList.removeAt(i);
    _timerList.insert(i, updatedPomodoro);

    // prefs.setStringList('Pomo${i + 1}', [
    //   updatedPomodoro.id,
    //   '${updatedPomodoro.focus}',
    //   '${updatedPomodoro.shortbreak}',
    //   '${updatedPomodoro.longbreak}',
    //   '${updatedPomodoro.laps}',
    //   updatedPomodoro.title,
    //   updatedPomodoro.icon
    // ]);
    notifyListeners();
  }
}
