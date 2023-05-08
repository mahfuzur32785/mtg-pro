import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/suggest_feature/controllers/suggest_feature_controller.dart';

import '../../repository/setting_pages_repository.dart';

class SuggestFeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find(),));
    Get.lazyPut(() => SuggestFeatureController(Get.find(),Get.find()));
  }

}