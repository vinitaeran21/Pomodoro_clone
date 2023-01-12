import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modelss/music_model.dart';

class MusicProvider with ChangeNotifier {
  List<Music> _listOfMusic = [
    Music(
        musicTitle: 'Rain with Thunderstorm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2F5_Minutes_of_Rain_and_Thunderstorm_(getmp3.pro).mp3?alt=media&token=753f77df-648b-4793-8b66-a8d142a8a34d',
        imageLocation: 'assets/rain_with_thunderstorm.jpg',
        categories: ['All', 'Rain']), // rain with thunder
    Music(
        musicTitle: 'Drizzle',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FDrizzle_Sound_Effect_Rain_Sound_Ef_(getmp3.pro).mp3?alt=media&token=feb45f6d-87b7-4bfe-a666-96f5be945256',
        imageLocation: 'assets/drizzle.jpg',
        categories: ['All', 'Rain']), //drizzle
    Music(
        musicTitle: 'Cricket sounds at night',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FCricket_Sound_in_the_Forest_to_Loop_(getmp3.pro).mp3?alt=media&token=02aec0e7-967a-4d54-95cd-5b01c0dd8af0',
        imageLocation: 'assets/cricket_forest.jpg',
        categories: ['All,Forest']), //cricket
    Music(
        musicTitle: 'Night Owl in Forest',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2Fowls_sound_effects_Owls_screeching_(getmp3.pro).mp3?alt=media&token=62639842-478e-4acc-a38a-0e3177489a00',
        imageLocation: 'assets/night_owl.jpg',
        categories: ['All', 'Forest', 'Birds']), //owl
    Music(
        musicTitle: 'RainForest',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FRainforest_Sound_Effect_(getmp3.pro).mp3?alt=media&token=d379a87e-e026-48b5-8d36-2e16d0c65d6e',
        imageLocation: 'assets/rainforest.jpg',
        categories: ['All', 'Forest']), //rainforest
    Music(
        musicTitle: 'Nightingale Singing',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FSpring_Birds_Chirping_Sound_Effect_(getmp3.pro).mp3?alt=media&token=de77d51d-e3b2-4c7e-b0a7-2468cff14a9e',
        imageLocation: 'assets/birds_chirping.jpg',
        categories: ['All', 'Birds', 'Forest']), //  birds
    Music(
        musicTitle: 'Fireplace',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FFireplace_Free_Sound_Royalty_Free_(getmp3.pro).mp3?alt=media&token=ece0e00c-29c4-4dce-8e54-b231c3391a7d',
        imageLocation: 'assets/fireplace.jpg',
        categories: ['All', 'Fire', 'Ambience']), //fireplace
    Music(
        musicTitle: 'Campfire in Forest',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FFireplace_Free_Sound_Royalty_Free_(getmp3.pro).mp3?alt=media&token=ece0e00c-29c4-4dce-8e54-b231c3391a7d',
        imageLocation: 'assets/campfire.jpg',
        categories: ['All', 'Forest', 'Fire']), //campfire
    Music(
        musicTitle: 'Sea Waves',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FRough_Sea_Waves_Loop_-_Sound_Effect_(getmp3.pro).mp3?alt=media&token=9fc57977-3860-4e18-aa56-ed4ae1990d9f',
        imageLocation: 'assets/Rough_sea_pillars.jpg',
        categories: ['All', 'Sea']), //sea waves
    Music(
        musicTitle: 'Cafe',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/pomodoro-820c9.appspot.com/o/audio%2FAmbience_Caf_Sound_(getmp3.pro).mp3?alt=media&token=923c4725-abe5-4d8d-b9c3-d3d8aee01219',
        imageLocation: 'assets/good-mornings-at-ambient.jpg',
        categories: ['All', 'Ambience']),
  ];

  MusicProvider() {
    _loadMusic();
  }

  List<Music> findByCategory(String category) {
    List<Music> MusicByCategory = [];
    for (var element in _listOfMusic) {
      if (element.categories.contains(category)) {
        MusicByCategory.add(element);
      }
    }
    return MusicByCategory;
  }

  Future<void> updateMusic(String url) async {
    Music music =
        _listOfMusic.firstWhere((element) => element.downloadUrl == url);
    int index = _listOfMusic.indexWhere((element) => element == music);
    _listOfMusic.removeAt(index);
    _listOfMusic.insert(
        index,
        Music(
            musicTitle: music.musicTitle,
            downloadUrl: music.downloadUrl,
            imageLocation: music.imageLocation,
            categories: music.categories,
            downloaded: true));
    notifyListeners();
    await _saveMusic();
  }

  Future _saveMusic() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setStringList(
        'musicList', _listOfMusic.map((p) => json.encode(p.toMap())).toList());
  }

  Future _loadMusic() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var result = _prefs.getStringList('musicList');
    if (result != null) {
      _listOfMusic = result.map((e) => Music.fromMap(jsonDecode(e))).toList();
    }
  }
}
