import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  String date;
  DateCard({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Text(
        date,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
      ),
    );
  }
}
