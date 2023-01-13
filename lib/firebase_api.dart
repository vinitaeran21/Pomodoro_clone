import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice123455/providers/music_provider.dart';
import 'package:provider/provider.dart';

class FirebaseApi {
  Future<bool> downloadFile(
      String downloadUrl, String title, BuildContext context) async {
    final Dio dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/$title';
    bool result = false;
    await dio.download(
      downloadUrl,
      path,
      onReceiveProgress: (recievedBytes, totalBytes) {
        double percent = recievedBytes / totalBytes * 100;
        print(percent);
        if (percent == 100) {
          result = true;
        }
      },
      deleteOnError: true,
    );

    return result;
  }
}
