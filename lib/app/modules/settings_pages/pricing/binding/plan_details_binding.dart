import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/controller/plan_details_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/controller/pricing_controller.dart';

class PlanDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlanDetailsController(Get.find()));
  }
}