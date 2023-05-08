import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/controller/order_controller.dart';

import '../../repository/setting_pages_repository.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => OrderController(Get.find(), Get.find()));
  }
}