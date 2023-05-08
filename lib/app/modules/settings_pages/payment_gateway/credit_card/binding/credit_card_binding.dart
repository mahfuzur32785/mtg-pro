import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/payment_gateway/credit_card/controller/credit_card_controller.dart';

class CreditCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreditCardController(Get.find(), Get.find()));
  }

}