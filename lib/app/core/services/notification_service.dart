import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/strings.dart';

class NotificationService {
  static Future<void> sendNotification(List<String> userIds, String heading, String contents) async {
    if (userIds.isEmpty) {
      userIds = await getDeviceId();
    }
    final result = await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": onesignalAppId,

        "include_player_ids": userIds,

        "android_accent_color":"FF191C27",

        "small_icon":"https://i.postimg.cc/B6XMvFBP/playstore.png",

        "large_icon":"https://i.postimg.cc/B6XMvFBP/playstore.png",

        "headings": {"en": heading},

        "contents": {"en": contents},

      }),
    );
    if (kDebugMode) {
      print("Notification : ${result.body.toString()}");
    }
  }

  static Future<List<String>> getDeviceId() async {
    List<String> ids = [];
    final status = await OneSignal.shared.getDeviceState();
    String? id = status!.userId;
    if (id != null) {
      ids.add(id);
    }
    return ids;
  }

  static cachedNotify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("notified",true);
  }

  static Future<bool?> isNotify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isNotified = preferences.getBool("notified");
    return isNotified;
  }
}