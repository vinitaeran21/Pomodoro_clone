import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:practice123455/providers/pomodoro_provider.dart';
import 'package:practice123455/screens/countdown_screen.dart';
import 'package:provider/provider.dart';

class Timings extends StatefulWidget {
  const Timings({Key? key}) : super(key: key);
  static String routename = 'timings';

  @override
  State<Timings> createState() => _TimingsState();
}

class _TimingsState extends State<Timings> {
  bool timerPaused = true;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  int currentPage = 0;
  final CountDownController controller1 = CountDownController();
  final CountDownController controller2 = CountDownController();
  final CountDownController controller3 = CountDownController();
  late CountDownController currentController;
  int lapsCompleted = 0;

  void SwitchCountDownMode(CountDownController controller) {
    if (!controller.isStarted) {
      controller.start();
    } else if (!controller.isPaused) {
      controller.pause();
    } else if (!controller.isResumed) {
      controller.resume();
    }
  }

  @override
  void initState() {
    super.initState();
    currentController = controller1;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerId = ModalRoute.of(context)!.settings.arguments as String;
    final timerData = Provider.of<PomodoroProvider>(context).findById(timerId);

    return SafeArea(
      child: Scaffold(
        body: PageView(
            physics: timerPaused
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) {
              currentPage = index;
              if (index == 0) {
                currentController = controller1;
              } else if (index == 1) {
                currentController = controller2;
              } else if (index == 2) {
                currentController = controller3;
              }
            },
            children: [
              FocusTimer(
                ringColor: Colors.yellow,
                pageTitle: 'Focus',
                timerLength: timerData.focus,
                controller: controller1,
                lapUpdate: () {
                  setState(() {
                    lapsCompleted += 1;
                    timerPaused = !timerPaused;
                  });
                  if (lapsCompleted == timerData.laps) {
                    pageController.animateToPage(2,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                  } else {
                    pageController.animateToPage(1,
                        duration: const Duration(seconds: 1),
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
                  pageController.animateToPage(0,
                      duration: const Duration(seconds: 1),
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
                  pageController.animateToPage(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                },
                timerTitle: '${timerData.title} ${timerData.icon}',
              )
            ]),
        bottomNavigationBar: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: 88,
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: myWidget(lapsCompleted),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 48,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.dehaze_outlined,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Mute',
                            style: TextStyle(color: Colors.black),
                          )),
                      const Spacer(),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          if (timerPaused) {
                            currentController.restart();
                            currentController.pause();
                          } else {
                            currentController.pause();
                            setState(() {
                              timerPaused = true;
                            });
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return buildAlertDialog(context);
                                });
                          }
                        },
                        icon: const Icon(
                          Icons.stop_rounded,
                          size: 32,
                        ),
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          SwitchCountDownMode(currentController);
                          setState(() {
                            timerPaused = !timerPaused;
                          });
                        },
                        icon: timerPaused
                            ? const Icon(Icons.play_arrow_rounded, size: 32)
                            : const Icon(Icons.pause, size: 32),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Are your sure you want to reset current session'),
      actions: [
        TextButton(
            onPressed: () {
              currentController.resume();
              Navigator.of(context).pop();
              setState(() {
                timerPaused = false;
              });
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              currentController.restart();
              currentController.pause();
              Navigator.of(context).pop();
            },
            child: const Text('Sure'))
      ],
    );
  }

  List<Text> myWidget(int count) {
    return List.generate(count, (i) => const Text("🍅")).toList();
  }
}
