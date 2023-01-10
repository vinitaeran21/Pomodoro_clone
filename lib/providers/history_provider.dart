import 'dart:convert';
import 'dart:io';
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

  void _saveHistory() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList(
        'history', _history.map((f) => jsonEncode(f.toMap())).toList());
  }

  void _loadHistory() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var data = _prefs.getStringList('history');
    if (data != null) {
      _history = data.map((f) => History.fromMap(json.decode(f))).toList();
      for (var element in _history) {
        print(element.toMap());
      }
      print('im here');
      notifyListeners();
    }
  }
}
