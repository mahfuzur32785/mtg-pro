import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NoInternetController extends GetxController {
  var isLoading = false.obs;
  final LoginController _loginController;
  NoInternetController(this._loginController);

  checkInternet() async {
    // getSession();
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      goPage();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      goPage();
    } else {
      Get.snackbar("Network Error", "No Internet Connection");
    }

    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     // connected
    //     // bool isLoggedIn = await MySharedPreference.isLoggedIn();
    //     // bool isCard = await MySharedPreference.isCard();
    //     // bool isOnBoarding = await MySharedPreference.isOnBoardingShown();
    //     print("ccccccccc");
    //     if (_loginController.isLoggedIn) {
    //       if (_loginController.isAvailableCard) {
    //         Get.offAllNamed(Routes.home);
    //       } else {
    //         Get.offAllNamed(Routes.stepVCardsName);
    //       }
    //     } else {
    //       Get.offAllNamed(Routes.login);
    //     }
    //   } else {
    //     Get.snackbar("Network Error", "No Internet Connection");
    //   }
    // } on SocketException catch (_) {
    //   Get.snackbar("Network Error", "No Internet Connection");
    // }

  }

  void goPage() {
    if (_loginController.isLoggedIn) {
      if (_loginController.isAvailableCard) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.stepVCardsName);
      }
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

}