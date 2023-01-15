import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice123455/providers/history_provider.dart';
import 'package:practice123455/providers/music_provider.dart';
import 'package:practice123455/providers/pomodoro_provider.dart';
import 'package:practice123455/screens/History.dart';
import 'package:practice123455/screens/home.dart';
import 'package:practice123455/screens/timings_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider.value(value: MusicProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
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
        routes: {
          Timings.routename: (ctx) => const Timings(),
          HistoryScreen.routeName: (ctx) => HistoryScreen()
        },
        home: Home(),
      ),
    );
  }
}
