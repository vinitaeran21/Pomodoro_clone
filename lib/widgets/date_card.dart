import 'package:flutter/material.dart';
import 'package:practice123455/providers/history_provider.dart';
import 'package:practice123455/widgets/history_card.dart';
import 'package:provider/provider.dart';

class DateCard extends StatelessWidget {
  String date;
  DateCard({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyData = Provider.of<HistoryProvider>(context);
    final historyListByDate = historyData.GetByDate(date);
    return Padding(
      padding: EdgeInsets.only(
        top: 4,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Text(
        date,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
      ),
    );
  }
}
