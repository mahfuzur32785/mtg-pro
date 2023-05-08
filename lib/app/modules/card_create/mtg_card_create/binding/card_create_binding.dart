import 'package:get/get.dart';

import '../controller/card_create_repository.dart';
import '../controller/mtg_card_create_controller.dart';

class CardCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardCreateRepository>(() => CardCreateRepositoryImpl(Get.find()));
    Get.lazyPut(() => MtgCreateCardController(Get.find(), Get.find()));
  }

}