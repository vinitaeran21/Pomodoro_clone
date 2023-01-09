import 'package:flutter/material.dart';
import 'package:practice123455/providers/history_provider.dart';
import 'package:practice123455/providers/pomodoro_provider.dart';
import 'package:practice123455/screens/all_timers_screen.dart';
import 'package:practice123455/screens/home.dart';
import 'package:practice123455/screens/timings_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PomodoroProvider(),
        ),
        ChangeNotifierProvider.value(
          value: HistoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              actionsIconTheme: IconThemeData(color: Colors.blue),
              elevation: 0,
              color: Colors.white,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        routes: {Timings.routename: (ctx) => Timings()},
        home: Home(),
      ),
    );
  }
}
