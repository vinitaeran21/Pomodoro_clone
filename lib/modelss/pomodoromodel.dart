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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'focus': focus,
      'shortbreak': shortbreak,
      'longbreak': longbreak,
      'laps': laps,
      'title': title,
      'icon': icon
    };
  }

  factory Pomodoro.fromMap(Map<String, dynamic> map) => Pomodoro(
      id: map['id'],
      focus: map['focus'],
      longbreak: map['longbreak'],
      shortbreak: map['shortbreak'],
      laps: map['laps'],
      title: map['title'],
      icon: map['icon']);
}
