import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice123455/pomodoro_provider.dart';
import 'package:practice123455/screens/countdown_screen.dart';
import 'package:provider/provider.dart';

class Timings extends StatefulWidget {
  Timings({Key? key}) : super(key: key);
  static String routename = 'timings';

  @override
  State<Timings> createState() => _TimingsState();
}

class _TimingsState extends State<Timings> {
  bool timerPaused = true;
  PageController controller = PageController(initialPage: 0);
  int currentPage = 0;
  final CountDownController controller1 = CountDownController();
  final CountDownController controller2 = CountDownController();
  final CountDownController controller3 = CountDownController();
  late CountDownController currentController;
  int lapsCompleted = 0;

  void SwitchCountDownMode(CountDownController controller) {
    if (!controller.isStarted) {
      setState(() {
        controller.start();
      });
    } else if (!controller.isPaused) {
      setState(() {
        controller.pause();
      });
    } else if (!controller.isResumed) {
      setState(() {
        controller.resume();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    currentController = controller1;
  }

  @override
  Widget build(BuildContext context) {
    final timerId = ModalRoute.of(context)!.settings.arguments as String;
    final timerData = Provider.of<PomodoroProvider>(context).findById(timerId);

    return SafeArea(
      child: Scaffold(
          body: PageView(
              physics: timerPaused
                  ? ScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) {
                print(currentPage);
                currentPage = index;
                if (index == 0)
                  currentController = controller1;
                else if (index == 1)
                  currentController = controller2;
                else if (index == 2) currentController = controller3;
              },
              children: [
                FocusTimer(
                  ringColor: Colors.yellow,
                  pageTitle: 'Focus',
                  timerLength: timerData.focus,
                  controller: controller1,
                  lapUpdate: () {
                    print('im here 4');

                    setState(() {
                      lapsCompleted += 1;
                      timerPaused = !timerPaused;
                    });
                    if (lapsCompleted == timerData.laps)
                      controller.animateToPage(2,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut);
                    else {
                      controller.animateToPage(1,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut);
                    }
                  },
                  timerTitle: '${timerData.title} ${timerData.icon}',
                ),
                FocusTimer(
                  ringColor: Colors.green,
                  pageTitle: 'Short Break',
                  timerLength: timerData.shortbreak,
                  controller: controller2,
                  lapUpdate: () {
                    setState(() {
                      timerPaused = !timerPaused;
                    });
                    controller.animateToPage(0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut);
                  },
                  timerTitle: '${timerData.title} ${timerData.icon}',
                ),
                FocusTimer(
                  ringColor: Colors.blue,
                  pageTitle: 'Long Break',
                  timerLength: timerData.longbreak,
                  controller: controller3,
                  lapUpdate: () {
                    setState(() {
                      timerPaused = !timerPaused;
                      lapsCompleted = 0;
                    });
                    controller.animateToPage(0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut);
                  },
                  timerTitle: '${timerData.title} ${timerData.icon}',
                )
              ]),
          bottomNavigationBar: GestureDetector(
              onTap: () {},
              child: Container(
                height: 88,
                child: ListView(
                  children: [
                    Container(
                        height: 40,
                        color: Colors.black,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: myWidget(lapsCompleted))),
                    Container(
                      color: Colors.white,
                      height: 48,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.dehaze_outlined,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Mute',
                                style: TextStyle(color: Colors.black),
                              )),
                          Spacer(),
                          IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              if (timerPaused) {
                                currentController.restart();
                                currentController.pause();
                              } else {
                                setState(() {
                                  timerPaused = true;
                                });
                                currentController.pause();
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text(
                                            'Are your sure you want to reset current session'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                currentController.resume();
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  timerPaused = false;
                                                });
                                              },
                                              child: Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                currentController.restart();
                                                currentController.pause();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Sure'))
                                        ],
                                      );
                                    });
                              }
                            },
                            icon: Icon(
                              Icons.stop_rounded,
                              size: 32,
                            ),
                          ),
                          IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              print(controller1.isStarted);
                              SwitchCountDownMode(currentController);
                              setState(() {
                                timerPaused = !timerPaused;
                              });
                            },
                            icon: timerPaused
                                ? Icon(Icons.play_arrow_rounded, size: 32)
                                : Icon(Icons.pause, size: 32),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  List<Text> myWidget(int count) {
    return List.generate(count, (i) => Text("🍅")).toList();
  }
}
