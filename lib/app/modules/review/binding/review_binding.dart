import 'package:get/get.dart';
import 'package:mtgpro/app/modules/review/review_controller.dart';

import '../../settings_pages/repository/setting_pages_repository.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => ReviewController(Get.find(), Get.find()));
  }
}