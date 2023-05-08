import 'package:get/get.dart';
import 'package:mtgpro/app/modules/history/controller/card_view_history_controller.dart';
import 'package:mtgpro/app/modules/history/controller/contact_download_history_controller.dart';

class ContactDownloadHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactDownloadHistoryController(Get.find(), Get.find()));
  }

}