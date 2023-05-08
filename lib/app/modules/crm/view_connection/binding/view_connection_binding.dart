import 'package:get/get.dart';
import 'package:mtgpro/app/modules/crm/view_connection/controller/view_connection_controller.dart';

import '../../../settings_pages/repository/setting_pages_repository.dart';

class ViewConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => ViewConnectionController(Get.find(),Get.find()));
  }

}