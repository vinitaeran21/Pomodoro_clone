import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modelss/history_model.dart';

class HistoryProvider with ChangeNotifier {
  List<History> _history = [];
  static late String datetime;

  HistoryProvider() {
    _loadHistory();
  }

  List<History> get HistoryList => [..._history.reversed];

  List<History> GetByDate(String startDate) {
    List<History> historyByDate = [];
    for (var element in _history) {
      if (element.startDate == startDate) {
        historyByDate.add(element);
      }
    }
    return historyByDate;
  }

  List<String> get ListOfDates {
    List<String> _listOfStartDates = [];
    for (var element in _history) {
      _listOfStartDates.add(element.startDate);
    }

    return _listOfStartDates.toSet().toList().reversed.toList();
  }

  void addHistory(
      String title, DateTime endDateTime, Duration length, String type) {
    _history.add(History(
        startDate: DateFormat('yMMMMd').format(endDateTime.subtract(length)),
        title: title,
        endDateTime: endDateTime,
        length: length,
        type: type));
    notifyListeners();
    _saveHistory();
  }

  Map<String, List> SummaryData() {
    String today = DateFormat('yMMMMd').format(DateTime.now());
    int todayTime = 0;
    int todaySession = 0;
    int weekSession = 0;
    int weekTime = 0;
    int totalTime = 0;
    int totalSession = 0;

    for (var element in _history) {
      if (element.type == 'Focus') {
        if (element.startDate == today) {
          todaySession += 1;
          todayTime += element.length.inMinutes;
        }
        if (element.endDateTime
            .subtract(element.length)
            .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
          weekSession += 1;
          weekTime += element.length.inMinutes;
        }
        totalTime += element.length.inMinutes;
        totalSession += 1;
      }
    }
    return {
      'Today': ['${todayTime ~/ 60} hour\n${todayTime % 60} min', todaySession],
      'Week': ['${weekTime ~/ 60} hour\n${weekTime % 60} min', weekSession],
      'Total': ['${totalTime ~/ 60} hour\n${totalTime % 60} min', totalSession]
    };
  }

  //------------------SharedPreferences Functions Below------------------------

  void _loadHistory() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var data = _prefs.getStringList('history');
    if (data != null) {
      _history = data.map((f) => History.fromMap(json.decode(f))).toList();
      notifyListeners();
    }
  }

  void _saveHistory() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList(
        'history', _history.map((f) => jsonEncode(f.toMap())).toList());
  }
}
