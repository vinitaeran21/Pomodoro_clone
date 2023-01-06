import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:practice123455/modelss/pomodoromodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PomodoroProvider with ChangeNotifier {
  late List<Pomodoro> _timerList;

  PomodoroProvider() {
    _timerList = [
      Pomodoro(
          id: Uuid().v4(),
          focus: 25,
          shortbreak: 5,
          longbreak: 15,
          laps: 4,
          title: 'Pomodoro',
          icon: '🍅')
    ];
    loadTimers();
  }

  List<Pomodoro> get timers => [..._timerList];

  // _initPrefs() async {
  //   _prefs ??= await SharedPreferences.getInstance();
  // }

  loadTimers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var result = _prefs.getStringList('Pomodoros');
    if (result != null) {
      _timerList = result.map((f) => Pomodoro.fromMap(json.decode(f))).toList();
    }
    // for (int i = 0;; i++) {
    //   if (_prefs.containsKey('Pomo$i')) {
    //     List<String> pomoData = _prefs.getStringList('Pomo$i')!;
    //     _timerList[i] = Pomodoro(
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
    notifyListeners();
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
    _saveTimers();
  }

  void EditingPomodoro(Pomodoro updatedPomodoro) async {
    int i =
        _timerList.indexWhere((element) => element.id == updatedPomodoro.id);
    _timerList.removeAt(i);
    _timerList.insert(i, updatedPomodoro);
    notifyListeners();
    _saveTimers();
  }

  _saveTimers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    List<String> myPomodoros =
        _timerList.map((p) => json.encode(p.toMap())).toList();

    _prefs.setStringList('Pomodoros', myPomodoros);
  }
}
