import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/controller/pricing_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';

class PricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => PricingController(Get.find()));
  }
}