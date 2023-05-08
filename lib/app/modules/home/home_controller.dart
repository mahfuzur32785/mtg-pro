import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/crm/crm_screen.dart';
import 'package:mtgpro/app/modules/home_cards/home_card_screen.dart';
import 'package:mtgpro/app/modules/insights/insights_screen.dart';
import 'package:mtgpro/app/modules/more/more_screen.dart';
import 'package:mtgpro/app/modules/scan/scan_screen.dart';
import 'package:mtgpro/app/modules/settings/settings_screen.dart';

import '../../core/services/notification_service.dart';
import '../../core/values/colors.dart';
import '../home_cards/model/card_model.dart';
import '../review/review_screen.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  int pageIndex = 0;
  var pageController = PageController(
    initialPage: 0,
  );

  void changePage(int index){
    pageIndex = index;
    update();
  }

  List<Widget> screenList = [
    const HomeCardsScreen(),
    // const CrmScreen(),
    // const MyReviewScreen(),
    // const MoreScreen(),
    InsightsScreen(),
    const SettingsScreen()
  ];

  Future<bool> onBackPressed(context) async {
    if (pageIndex != 0) {
      changePage(0);
      pageController.jumpToPage(0);
      return false;
    } else {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          title: const Text('Are you sure you want to close application?',style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400),),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'No',
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
          ],
        ),
      )) ??
          false;
    }
  }

  @override
  void onInit() async {
    bool? isNotified = await NotificationService.isNotify();
    if (isNotified == null) {
      await NotificationService.sendNotification([], "Welcome", "Thank you for install our app.").then((value) async {
        NotificationService.cachedNotify();
      });
    }
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}