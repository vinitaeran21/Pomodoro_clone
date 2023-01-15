import 'package:flutter/material.dart';
import 'package:practice123455/screens/History.dart';

import '../widgets/stats_summary_container.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);
  static const routeName = 'Statistics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f6),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f6),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HistoryScreen.routeName);
              },
              icon: const Icon(Icons.dehaze_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: const Text(
                'SUMMARY',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SummaryContainer()
          ],
        ),
      ),
    );
  }
}
