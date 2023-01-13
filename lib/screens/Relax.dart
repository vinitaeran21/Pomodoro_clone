import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice123455/providers/music_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/music_grid.dart';

List<String> categoriesListText = [
  'All',
  'Birds',
  'Rain',
  'Sea',
  'Fire',
  'Forest',
  'Ambience'
];

class RelaxScreen extends StatefulWidget {
  const RelaxScreen({Key? key}) : super(key: key);

  @override
  State<RelaxScreen> createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
  int currentCategory = 0;
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

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

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    setAudio();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<MusicProvider>(context);
    final currentMusic = Data.currentlyPlaying();
    setAudio();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04, bottom: 8),
            child: Text(
              'Relax',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            color: Colors.white,
            height: 32,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4),
                itemCount: categoriesListText.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentCategory = i;
                      });
                    },
                    child: Container(
                      height: 16,
                      width: 64,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: currentCategory == i
                              ? Color(0xff535353)
                              : Color(0xfff2f2f6)),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${categoriesListText[i]}',
                              style: currentCategory == i
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    )
                                  : TextStyle(
                                      color: Color(0xff555555),
                                      fontWeight: FontWeight.w400),
                            )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: MusicImagesGrid(
              categoryName: categoriesListText[currentCategory],
            ),
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {},
        child: Container(
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
                    currentMusic == null ? 'Mute' : currentMusic.musicTitle,
                    style: TextStyle(color: Colors.black),
                  )),
              const Spacer(),
              IconButton(
                splashRadius: 1,
                onPressed: () {
                  if (isPlaying == true) {
                    setState(() {
                      isPlaying = !isPlaying;
                      player.pause();
                    });
                  } else {
                    setState(() {
                      isPlaying = !isPlaying;
                      player.resume();
                    });
                  }
                },
                icon: isPlaying
                    ? const Icon(Icons.pause, size: 32)
                    : const Icon(Icons.play_arrow_rounded, size: 32),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
