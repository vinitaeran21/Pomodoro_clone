import 'package:flutter/material.dart';
import 'package:practice123455/modelss/history_model.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final History historyData;
  const HistoryCard({Key? key, required this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.05,
          top: 4,
          bottom: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                historyData.startDate,
                style: const TextStyle(fontSize: 8, color: Colors.grey),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.4),
                child: Text(historyData.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              Text(
                '${DateFormat('jm').format(historyData.endDateTime.subtract(historyData.length))} - ${DateFormat('jm').format(historyData.endDateTime)}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(historyData.type,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                historyData.length.inHours ~/ 60 != 0
                    ? '${historyData.length.inHours ~/ 60} hours ${historyData.length.inMinutes % 60} min'
                    : '${historyData.length.inMinutes % 60} min',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
              )
            ],
          ),
        ],
      ),
    );
  }
}
