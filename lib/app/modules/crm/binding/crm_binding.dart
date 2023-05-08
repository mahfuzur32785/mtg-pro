import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/controller/order_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';

import '../controller/crm_controller.dart';


class CrmBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => CrmController(Get.find(), Get.find()));
  }
}