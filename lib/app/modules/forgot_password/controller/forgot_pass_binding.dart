import 'package:get/get.dart';
import 'package:mtgpro/app/modules/forgot_password/controller/forgor_pass_controller.dart';

import '../../settings_pages/repository/setting_pages_repository.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find(),));
    Get.lazyPut(() => ForgotPasswordController(Get.find()));
  }
}