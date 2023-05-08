import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../settings_pages/repository/setting_pages_repository.dart';
import '../edit_connection_controller.dart';

class EditConnectionBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => EditConnectionController(Get.find(),Get.find()));
  }

}