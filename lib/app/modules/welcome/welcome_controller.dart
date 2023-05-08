import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var isLoading = false.obs;

  var pageController = PageController(
    initialPage: 0,
  );
  int pageIndex = 0;
  void changePage(int index){
    pageIndex = index;
    update();
  }

  final height = MediaQuery.of(Get.context!).size.height;
  final width = MediaQuery.of(Get.context!).size.width;

  late Timer timer;
  int start = 1000;
  final twoSec = const Duration(seconds: 2);

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  Color getColor(){
    if (pageIndex == 0) {
      return Colors.pink;
    }
    if (pageIndex == 1) {
      return Colors.green;
    }
    if (pageIndex == 2) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  void startTimer(){
    timer = Timer.periodic(twoSec, (timer) {
      if (start % 3 == 0) {
        if (kDebugMode) {
          print("$start");
        }
        start--;
        print("controller ${pageController.page}") ;
        if (pageController.page == 2.0) {
          pageController.animateToPage(0, duration: const Duration(milliseconds: 1000), curve: Curves.ease);
        } else {
          pageController.nextPage(duration: const Duration(milliseconds: 1000), curve: Curves.ease);
        }

        update();
        if (start == 1) {
          this.timer.cancel();
          timer.cancel();
        }
      } else {
        start--;
        update();
      }
    });
  }
}