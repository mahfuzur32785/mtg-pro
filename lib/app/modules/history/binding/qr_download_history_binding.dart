import 'package:get/get.dart';
import 'package:mtgpro/app/modules/history/controller/card_qr_download_history.dart';
import 'package:mtgpro/app/modules/history/controller/card_view_history_controller.dart';

class QrDownloadHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CardQrDownloadHistoryController(Get.find(), Get.find()));
  }

}