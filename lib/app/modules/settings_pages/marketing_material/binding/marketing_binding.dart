import 'package:get/get.dart';

import '../../repository/setting_pages_repository.dart';
import '../controller/marketing_controller.dart';

class MarketingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => MarketingController(Get.find(), Get.find()));
  }

}