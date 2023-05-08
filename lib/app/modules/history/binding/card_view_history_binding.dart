import 'package:get/get.dart';
import 'package:mtgpro/app/modules/history/controller/card_view_history_controller.dart';

class CardViewHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CardViewHistoryController(Get.find(), Get.find()));
  }

}