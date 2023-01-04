import 'package:flutter/material.dart';

class Pomodoro {
  DateTime id;
  int focus;
  int shortbreak;
  int longbreak;
  int roundsForLongBreak;
  String title;
  String icon;

  Pomodoro(
      {required this.id,
      required this.focus,
      required this.shortbreak,
      required this.longbreak,
      required this.roundsForLongBreak,
      required this.title,
      required this.icon});
}
