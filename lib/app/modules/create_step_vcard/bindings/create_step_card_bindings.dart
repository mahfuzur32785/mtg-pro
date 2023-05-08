import 'package:get/get.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_card_repository.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';

class CreateStepCardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateStepCardRepository>(() => CreateStepCardRepositoryImpl(Get.find()));
    Get.lazyPut(() => LoginController(Get.find(),));
    Get.lazyPut(() => CreateStepVcardController(Get.find(),Get.find()));
  }

}