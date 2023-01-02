import 'package:flutter/material.dart';

class Pomodoro {
  final DateTime id;
  int focus;
  int shortbreak;
  int longbreak;
  int roundsForLongBreak;
  String title;

  Pomodoro(
      {required this.id,
      this.focus = 15,
      this.shortbreak = 5,
      this.longbreak = 15,
      this.roundsForLongBreak = 4,
      this.title = 'Pomodoro'});
}
