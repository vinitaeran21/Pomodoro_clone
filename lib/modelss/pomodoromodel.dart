import 'package:flutter/material.dart';

class Pomodoro {
  String id;
  int focus;
  int shortbreak;
  int longbreak;
  int laps;
  String title;
  String icon;

  Pomodoro(
      {required this.id,
      required this.focus,
      required this.shortbreak,
      required this.longbreak,
      required this.laps,
      required this.title,
      required this.icon});
}
