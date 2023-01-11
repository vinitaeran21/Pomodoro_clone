import 'package:flutter/material.dart';
import 'package:practice123455/providers/history_provider.dart';
import 'package:provider/provider.dart';

class SummaryContainer extends StatelessWidget {
  const SummaryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HistoryProvider>(context).SummaryData();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      height: 200,
      child: LayoutBuilder(
        builder: (BuildContext context, constraints) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildColumn(
                constraints: constraints,
                header: 'Today',
                sessions: data['Today']![1],
                time: data['Today']![0]),
            SizedBox(
              width: 8,
            ),
            VerticalDivider(
              indent: constraints.maxHeight * 0.1,
              endIndent: constraints.maxHeight * 0.1,
            ),
            SizedBox(
              width: 8,
            ),
            buildColumn(
                constraints: constraints,
                header: 'This Week',
                sessions: data['Week']![1],
                time: data['Week']![0]),
            SizedBox(
              width: 8,
            ),
            VerticalDivider(
              indent: constraints.maxHeight * 0.1,
              endIndent: constraints.maxHeight * 0.1,
            ),
            SizedBox(
              width: 8,
            ),
            buildColumn(
                constraints: constraints,
                header: 'Total',
                sessions: data['Total']![1],
                time: data['Total']![0]),
          ],
        ),
      ),
    );
  }
}

Column buildColumn(
    {required BoxConstraints constraints,
    required String header,
    required String time,
    required int sessions}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        header,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height: constraints.maxHeight * 0.08,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        width: 56,
        decoration: BoxDecoration(
            color: Color(0xfff2f2f6), borderRadius: BorderRadius.circular(4)),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              time,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 12),
            )),
      ),
      SizedBox(
        height: constraints.maxHeight * 0.04,
      ),
      Text(
        'Focused Time',
        style: TextStyle(color: Colors.grey, fontSize: 10),
      ),
      SizedBox(
        height: constraints.maxHeight * 0.08,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        width: 64,
        decoration: BoxDecoration(
            color: Color(0xfff2f2f6), borderRadius: BorderRadius.circular(4)),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$sessions session',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 12),
            )),
      ),
      SizedBox(
        height: constraints.maxHeight * 0.04,
      ),
      Text(
        'Completed',
        style: TextStyle(color: Colors.grey, fontSize: 10),
      ),
    ],
  );
}
