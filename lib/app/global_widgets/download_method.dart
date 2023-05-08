import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';

import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

downloadingCallback(id, status, progress) {
  SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
  sendPort!.send([id, status, progress]);
}

goDownload({downloadUrl, fileName, context})async {

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Downloading",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );

  Directory? directory;
  String newPath = "";
  
  try {
    if(Platform.isIOS || Platform.isMacOS){
      // directory = await getLibraryDirectory();
      directory = await getDownloadsDirectory();
      print(directory?.path);

      directory ??= await getLibraryDirectory();

      File saveFile = File(directory.path);
      final fileName0 = "${fileName.split(" ").first}.pdf";

      if (kDebugMode) {
        print("final directory path : ${directory.path}");
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await FlutterDownloader.enqueue(
          url: downloadUrl,
          savedDir: saveFile.path,
          fileName: fileName0,
          showNotification: true,
          openFileFromNotification: true,
        );
      }

    } else if(Platform.isAndroid){
      directory = await getExternalStorageDirectory();
      print(directory?.path);

      List<String> paths = directory!.path.split("/");

      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/$folder";
        } else {
          break;
        }
      }
      newPath = "$newPath/Download";
      directory = Directory(newPath);

      print("new path ; "+newPath);

      final _fileName = "${fileName.split(" ").first}.pdf";
      File saveFile = File("${directory.path}");

      if (kDebugMode) {
        print("final directory path : "+directory.path);
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
         await FlutterDownloader.enqueue(
          url: downloadUrl,
          savedDir: saveFile.path,
          fileName: _fileName,
          showNotification: true,
          openFileFromNotification: true,
        );
      }
    }
  }catch (e){
    Helper.toastMsg("Something Went wrong...");
  }

}