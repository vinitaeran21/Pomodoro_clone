import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:practice123455/modelss/pomodoromodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PomodoroProvider with ChangeNotifier {
  late List<Pomodoro> _timerList = [
    Pomodoro(
        id: const Uuid().v4(),
        focus: 25,
        shortbreak: 5,
        longbreak: 15,
        laps: 4,
        title: 'Pomodoro',
        icon: '🍅')
  ];

  PomodoroProvider() {
    _loadTimers();
  }

  // to get list of timers in the main page
  List<Pomodoro> get timers => [..._timerList];

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

  // adding a new pomodoro
  void addPomodoro() {
    _timerList.add(Pomodoro(
        id: const Uuid().v4(),
        focus: 25,
        shortbreak: 5,
        longbreak: 15,
        laps: 4,
        title: 'Pomodoro',
        icon: '🍅'));
    notifyListeners();
    _saveTimers();
  }

  // Editing an existing pomodoro
  void EditingPomodoro(Pomodoro updatedPomodoro) async {
    int i =
        _timerList.indexWhere((element) => element.id == updatedPomodoro.id);
    _timerList[i] = updatedPomodoro;
    notifyListeners();
    _saveTimers();
  }

  // --------------------SharedPrefernces functions below-----------------------

  // update _timerList with already stored timers
  _loadTimers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('Pomodoros');
    if (result != null) {
      _timerList = result.map((f) => Pomodoro.fromMap(json.decode(f))).toList();
    }
    notifyListeners();
  }

  // storing updates in _timerList
  _saveTimers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
        'Pomodoros', _timerList.map((p) => json.encode(p.toMap())).toList());
  }
}
