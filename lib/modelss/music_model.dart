class Music {
  String musicTitle;
  String downloadUrl;
  bool downloaded;
  String imageLocation;
  List<String> categories;

  Music(
      {required this.musicTitle,
      required this.downloadUrl,
      this.downloaded = false,
      required this.imageLocation,
      required this.categories});

  factory Music.fromMap(Map map) {
    return Music(
        musicTitle: map['musicTitle'],
        downloaded: map['downloaded'],
        downloadUrl: map['downloadUrl'],
        imageLocation: map['imageLocation'],
        categories: map['categories']);
  }

  Map<String, dynamic> toMap() {
    return {
      'musicTitle': musicTitle,
      'downloaded': downloaded,
      'downloadUrl': downloadUrl,
      'imageLocation': imageLocation,
      'categories': categories
    };
  }
}
