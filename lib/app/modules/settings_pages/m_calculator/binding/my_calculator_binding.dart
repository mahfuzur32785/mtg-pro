import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/m_calculator/controller/my_calculator_controller.dart';

class MyCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MyCalculatorController());
  }

}