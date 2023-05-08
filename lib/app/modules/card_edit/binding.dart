import 'package:get/get.dart';
import 'package:mtgpro/app/modules/card_edit/controller/card_edit_controller.dart';

import '../card_create/mtg_card_create/controller/card_create_repository.dart';

class CardEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardCreateRepository>(() => CardCreateRepositoryImpl(Get.find()));
    Get.lazyPut(() => MtgCardEditController(Get.find(), Get.find(),Get.find()));
  }

}