import 'package:flutter/material.dart';
import 'package:practice123455/screens/Relax.dart';
import 'package:practice123455/screens/all_timers_screen.dart';
import 'package:practice123455/screens/statistics_screen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        // onPageChanged: (int val) {
        //   _pageController.jumpToPage(val);
        // },
        children: [
          const TimerScreen(),
          const RelaxScreen(),
          const Statistics()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        unselectedFontSize: 8,
        selectedFontSize: 8,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: (int val) {
          setState(() {
            currentPage = val;
          });
          _pageController.jumpToPage(currentPage);
        },
        currentIndex: currentPage,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.timer), label: 'Timers'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.music_note), label: 'Relax'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph_sharp), label: 'Statistics'),
        ],
      ),
    );
  }
}
