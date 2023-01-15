import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

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
        if (percent == 100) {
          result = true;
        }
      },
      deleteOnError: true,
    );

    return result;
  }
}
