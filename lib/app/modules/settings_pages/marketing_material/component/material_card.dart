import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mtgpro/app/data/dummy_data.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../global_widgets/download_method.dart';
import '../model/market_model.dart';

class MarketingCard extends StatefulWidget {
  const MarketingCard({Key? key, this.marketMaterialModel}) : super(key: key);

  final MarketMaterialModel? marketMaterialModel;

  @override
  State<MarketingCard> createState() => _MarketingCardState();
}

class _MarketingCardState extends State<MarketingCard> {
  bool isTap = false;
  void _onTapDown(TapDownDetails details) {
    setState(() {
      isTap = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        isTap = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallback); // callback is a top-level or static function
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomImage(path: widget.marketMaterialModel!.image,height: 100,width: 100,fit: BoxFit.cover,),
            // child: const Image(image: NetworkImage("https://mtgpro.me/assets/uploads/marketing-materials/1674973624.jpg"),height: 100,width: 100,fit: BoxFit.cover,),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.marketMaterialModel!.title,maxLines: 3,overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: () async {

                    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
                    final androidInfo = await deviceInfoPlugin.androidInfo;
                    final apiLevel = androidInfo.version.sdkInt;
                    PermissionStatus storagePermission;
                    var notificationPermission;

                    print(apiLevel);

                    if (apiLevel >= 33) {
                      storagePermission = await Permission.mediaLibrary.request();
                      notificationPermission = await Permission.notification.request();
                    }else{
                      storagePermission = await Permission.storage.request();
                      notificationPermission = await Permission.notification.request();
                    }
                    if (storagePermission == PermissionStatus.granted) {
                      if(notificationPermission == PermissionStatus.granted){
                        goDownload(downloadUrl: widget.marketMaterialModel!.file, fileName: widget.marketMaterialModel!.title,context: context);
                      }
                    }
                    else if (storagePermission == PermissionStatus.denied) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Storage Permission is required',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else if (storagePermission == PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    }
                  },
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(3)
                      ),
                        child: Text("Download",style: TextStyle(color: isTap ? Colors.black87 : Colors.blue),
                        ),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Download pdf in background
  // goDownload({downloadUrl, fileName})async {
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           "Downloading",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );
  //
  //     final _fileName = "${fileName.split(" ").first}.pdf";
  //     File saveFile = File("/storage/emulated/0/Download/");
  //
  //     await FlutterDownloader.enqueue(
  //       url: downloadUrl,
  //       savedDir: saveFile.path,
  //       fileName: _fileName,
  //       showNotification: true,
  //       openFileFromNotification: true,
  //     );
  //     print('Download Complete');
  //
  //     OpenFile.open(saveFile.path);
  //
  // }
}