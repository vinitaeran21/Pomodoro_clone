import 'package:flutter/material.dart';
import 'package:practice123455/providers/history_provider.dart';
import 'package:practice123455/widgets/history_card.dart';
import 'package:provider/provider.dart';
import 'package:group_list_view/group_list_view.dart';
import '../widgets/date_card.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  static const routeName = 'History';

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<HistoryProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: double.infinity,
          leading: TextButton.icon(
            icon: const Icon(Icons.arrow_back_outlined),
            label: const Text('Statistics'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0xfff2f2f6),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ],
        ),
        backgroundColor: const Color(0xfff2f2f6),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05, bottom: 8),
            child: const Text(
              'History',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: GroupListView(
                itemBuilder: (BuildContext context, IndexPath index) {
                  return HistoryCard(
                    historyData: Data.GetByDate(Data.ListOfDates[index.section])
                        .reversed
                        .toList()[index.index],
                  );
                },
                sectionsCount: Data.ListOfDates.length,
                groupHeaderBuilder: (BuildContext context, int section) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DateCard(date: Data.ListOfDates[section]),
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.05,
                          endIndent: MediaQuery.of(context).size.width * 0.05,
                        )
                      ]);
                },
                countOfItemInSection: (int section) {
                  return Data.GetByDate(Data.ListOfDates[section]).length;
                },
                separatorBuilder: (BuildContext context, IndexPath i) {
                  return Divider(
                    indent: MediaQuery.of(context).size.width * 0.05,
                    endIndent: MediaQuery.of(context).size.width * 0.05,
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
