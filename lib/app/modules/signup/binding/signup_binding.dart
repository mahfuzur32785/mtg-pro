import 'package:get/get.dart';
import 'package:mtgpro/app/modules/signup/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController(Get.find(),Get.find()));
  }

}