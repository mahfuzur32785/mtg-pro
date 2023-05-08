import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';
import '../controller/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find(),));
    Get.lazyPut(() => SupportController(Get.find(),Get.find()));
  }

}