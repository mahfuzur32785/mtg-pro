import 'package:get/get.dart';
import 'package:mtgpro/app/modules/card_view/controller/care_preview_repository.dart';

import '../controller/card_view_controller.dart';

class CardPreviewBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CardPreviewRepository>(() => CardPreviewRepositoryImpl(Get.find()));
    Get.lazyPut(() => CardViewController(Get.find(),Get.find()));
  }

}