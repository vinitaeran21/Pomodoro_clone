import 'package:flutter/material.dart';
import 'package:practice123455/widgets/music_grid.dart';

class SoundsBottomSheet extends StatelessWidget {
  const SoundsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: MusicImagesGrid(
        categoryName: 'All',
      ),
    );
  }
}
