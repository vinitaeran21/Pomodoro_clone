import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice123455/providers/pomodoro_provider.dart';
import 'package:practice123455/screens/countdown_screen.dart';
import 'package:practice123455/screens/sounds_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../providers/music_provider.dart';

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
  AudioPlayer player = AudioPlayer();

  void setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    final dir = await getApplicationDocumentsDirectory();
    String? title = Provider.of<MusicProvider>(context, listen: false)
        .currentlyPlaying()
        ?.musicTitle;
    if (title != null) {
      String path = '${dir.path}/$title';
      player.setSourceDeviceFile(path);
    }
  }

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
    player.onPlayerStateChanged.listen((event) {
      // setState(() {
      //   isPlaying = event == PlayerState.playing;
      // });
    });
    setAudio();
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
    final currentMusic = Provider.of<MusicProvider>(context).currentlyPlaying();

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
          onTap: () {
            showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => const SoundsBottomSheet())
                .then((_) => setAudio());
          },
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
                          label: Text(
                            currentMusic!.musicTitle,
                            style: const TextStyle(color: Colors.black),
                          )),
                      const Spacer(),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          if (timerPaused) {
                            currentController.restart();
                            currentController.pause();
                          } else {
                            player.pause();
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
                          if (timerPaused) {
                            player.resume();
                          } else {
                            player.pause();
                          }
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
              player.resume();
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
