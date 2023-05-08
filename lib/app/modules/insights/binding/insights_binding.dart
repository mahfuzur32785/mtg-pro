import 'package:get/get.dart';
import 'package:mtgpro/app/modules/insights/controller/insights_controller.dart';
import 'package:mtgpro/app/modules/insights/controller/insights_repository.dart';

class InsightsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsightsRepository>(() => InsightsRepositoryImpl(Get.find()));
    Get.lazyPut(() => InsightsController(Get.find(), Get.find()));
  }

}