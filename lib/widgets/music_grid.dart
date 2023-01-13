import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice123455/modelss/music_model.dart';
import 'package:practice123455/providers/music_provider.dart';
import 'package:provider/provider.dart';

import '../firebase_api.dart';

class MusicImagesGrid extends StatelessWidget {
  String categoryName;

  MusicImagesGrid({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<MusicProvider>(context);
    final musicList = Data.findByCategory(categoryName);
    return GridView.builder(
        itemCount: musicList.length,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            crossAxisSpacing: 8),
        itemBuilder: (context, i) {
          return MusicImage(musicData: musicList[i]);
        });
  }
}

class MusicImage extends StatelessWidget {
  MusicImage({
    Key? key,
    required this.musicData,
  }) : super(key: key);

  Music musicData;

  Future<bool> downloadFile(BuildContext ctx) async {
    bool result = await FirebaseApi()
        .downloadFile(musicData.downloadUrl, musicData.musicTitle, ctx) as bool;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<MusicProvider>(context);
    return GestureDetector(
      onTap: () {
        if (musicData.downloaded) Data.updateCurrentlyPlaying(musicData);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GridTile(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!musicData.downloaded)
                  IconButton(
                      onPressed: () async {
                        bool result = await downloadFile(context);
                        if (result == true) {
                          await Data.updateMusic(musicData.downloadUrl);
                        }
                      },
                      icon: Icon(
                        Icons.download_for_offline_outlined,
                        color: Colors.white,
                      ))
              ],
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                musicData.musicTitle,
                textAlign: TextAlign.center,
              ),
            ),
            child: Image.asset(
              musicData.imageLocation,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
