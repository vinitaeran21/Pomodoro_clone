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
    _loadTimers();
  }

  List<Pomodoro> get timers => [..._timerList];

  _loadTimers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var result = _prefs.getStringList('Pomodoros');
    if (result != null) {
      _timerList = result.map((f) => Pomodoro.fromMap(json.decode(f))).toList();
    }
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

    _prefs.setStringList(
        'Pomodoros', _timerList.map((p) => json.encode(p.toMap())).toList());
  }
}
