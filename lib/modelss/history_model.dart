class History {
  final String startDate;
  final DateTime endDateTime;
  final Duration length;
  final String type;
  final String title;

  History(
      {required this.startDate,
      required this.endDateTime,
      required this.length,
      required this.type,
      required this.title});

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate,
      'endDateTime': endDateTime.toIso8601String(),
      'length': length.inMinutes.toString(),
      'type': type,
      'title': title
    };
  }

  factory History.fromMap(Map<String, dynamic> map) => History(
      startDate: map['startDate'],
      endDateTime: DateTime.parse(map['endDateTime']),
      length: Duration(minutes: int.parse(map['length'])),
      type: map['type'],
      title: map['title']);
}
