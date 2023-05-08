import 'package:get/get.dart';
import '../../repository/setting_pages_repository.dart';
import '../controller/subscription_controller.dart';

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => SubscriptionController(Get.find(),Get.find()));
  }
}