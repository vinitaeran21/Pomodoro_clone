import 'package:flutter/material.dart';
import 'package:practice123455/providers/music_provider.dart';
import 'package:provider/provider.dart';

class MusicImagesGrid extends StatelessWidget {
  String categoryName;

  MusicImagesGrid({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<MusicProvider>(context);
    // final musicList = Data.listOfMusic;
    return GridView.builder(
        itemCount: 6,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            crossAxisSpacing: 8),
        itemBuilder: (context, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/rain_with_thunderstorm.jpg',
              fit: BoxFit.cover,
            ),
          );
        });
  }
}
