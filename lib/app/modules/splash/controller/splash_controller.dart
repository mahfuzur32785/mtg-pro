import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mtgpro/app/core/services/notification_service.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/values/strings.dart';


class SplashController extends GetxController {
  var isLoading = false.obs;
  final LoginController _loginController;
  SplashController(this._loginController);

  final formatter = DateFormat("yyyy-MM-dd hh:mm");
  //......... Biometric Auth ..........
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  @override
  void onInit() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.onInit();
    startTime();
  }

  createSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String session = const Uuid().v4();
    localStorage.setString(MySharedPreference.sSESSION, session);
    MySharedPreference.session = session;
  }

  getSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? session = localStorage.getString(MySharedPreference.sSESSION);
    if (kDebugMode) {
      print(session);
    }
    if (session == null) {
      createSession();
    }else {
      MySharedPreference.session = session;
    }
  }

  int getDays(String date) {
    DateTime dob = DateTime.parse(date);
    Duration dur = dob.difference(DateTime.now());
    int differenceDays = dur.inDays;
    return differenceDays;
  }

  startTime() async {
    // getSession();
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      if (_loginController.isLoggedIn) {
        //...... biometric login..........
        bool isBiometric = await isBiometricAvailable();
        if(!isBiometric) {
          if (_loginController.isAvailableCard) {
            return Timer(kDuration, navigateToHomePage);
          } else {
            return Timer(kDuration, navigateToStepCardCreate);
          }
        }
        final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
        if (availableBiometrics.isEmpty) {
          if (_loginController.isAvailableCard) {
            return Timer(kDuration, navigateToHomePage);
          } else {
            return Timer(kDuration, navigateToStepCardCreate);
          }
        }

        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please unlock to open app',
            options: const AuthenticationOptions(
                biometricOnly: true,
              sensitiveTransaction: true,
              useErrorDialogs: true,
              stickyAuth: true,
            ),
            // authMessages: const <AuthMessages>[
            //   AndroidAuthMessages(
            //     signInTitle: 'Oops! Biometric authentication required!',
            //     cancelButton: 'No thanks',
            //   ),
            //   IOSAuthMessages(
            //     cancelButton: 'No thanks',
            //   ),
            // ]
          );

          if (didAuthenticate) {
            if (_loginController.isAvailableCard) {
              return Timer(kDuration0, navigateToHomePage);
            } else {
              return Timer(kDuration0, navigateToStepCardCreate);
            }
          } else {
            return Timer(kDuration0, navigateToLoginPage);
          }
        } on PlatformException catch (e){
          print("xxxxxxxxxxxxxxxxx exeption xxxxxxxxxxxxxxxxx");
          print("............. ${e.message}  ...........");
          if (_loginController.isAvailableCard) {
            return Timer(kDuration, navigateToHomePage);
          } else {
            return Timer(kDuration, navigateToStepCardCreate);
          }
        }

      }
      // else if (isOnBoarding){
      //   return Timer(kDuration, navigateToLoginPage);
      // }
      // return Timer(kDuration, navigateToWelcome);
      print("//////////////////////");
      return Timer(kDuration, navigateToLoginPage);
    }  else {
      return Timer(kDuration, noInternetPage);
    }

    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     // connected
    //     // bool isLoggedIn = await MySharedPreference.isLoggedIn();
    //     // bool isCard = await MySharedPreference.isCard();
    //     // bool isOnBoarding = await MySharedPreference.isOnBoardingShown();
    //
    //     if (_loginController.isLoggedIn) {
    //       if (_loginController.isAvailableCard) {
    //         return Timer(kDuration, navigateToHomePage);
    //       } else {
    //         return Timer(kDuration, navigateToStepCardCreate);
    //       }
    //     }
    //     // else if (isOnBoarding){
    //     //   return Timer(kDuration, navigateToLoginPage);
    //     // }
    //     // return Timer(kDuration, navigateToWelcome);
    //     return Timer(kDuration, navigateToLoginPage);
    //   } else {
    //     // not connected
    //     return Timer(kDuration, noInternetPage);
    //   }
    // } on SocketException catch (_) {
    //   // not connected
    //   if (kDebugMode) {
    //     print('not connected');
    //   }
    //   return Timer(kDuration, noInternetPage);
    // }

  }

  void navigateToHomePage() {
    Get.offAllNamed(Routes.home);
  }

  void navigateToStepCardCreate() {
    Get.offAllNamed(Routes.stepVCardsName);
  }

  void noInternetPage() {
    Get.offAllNamed(Routes.noInternet);
  }

  void navigateToLoginPage() {
    Get.offAllNamed(Routes.login);
  }
  void navigateToWelcome() {
    Get.offAllNamed(Routes.welcomeScreen);
  }

}