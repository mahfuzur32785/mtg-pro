import 'package:get/get.dart';
import 'package:mtgpro/app/modules/home_cards/controller/card_list_repository.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';

import '../../scanner/controller/scanner_controller.dart';

class HomeCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScannerController(Get.find()));
    Get.lazyPut<CardListRepository>(() => CardListRepositoryImpl(Get.find(),Get.find()));
    Get.lazyPut(() => HomeCardsController(Get.find(), Get.find(),Get.find()));
  }

}