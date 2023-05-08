import 'package:get/get.dart';
import 'package:mtgpro/app/modules/nfc/write_nfc/controller/write_nfc_controller.dart';

class WriteNfcCardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => WriteNfcController());
  }

}