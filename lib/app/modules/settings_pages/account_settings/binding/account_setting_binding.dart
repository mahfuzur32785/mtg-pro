import 'package:get/get.dart';

import '../../repository/setting_pages_repository.dart';
import '../controller/account_setting_controlller.dart';

class AccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find(),));
    Get.lazyPut(() => AccountSettingController(Get.find(),Get.find(),Get.find()));
  }

}