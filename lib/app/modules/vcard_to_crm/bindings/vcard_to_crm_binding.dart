import 'package:get/get.dart';
import 'package:mtgpro/app/modules/vcard_to_crm/controller/vcard_to_crm_controller.dart';
import 'package:mtgpro/app/modules/vcard_to_crm/controller/vcard_to_crm_repository.dart';

class VCardToCrmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VCardToCrmRepository>(() => VCardToCrmRepositoryImpl(Get.find()));
    Get.lazyPut(() => VCardToCrmController(Get.find(),Get.find()));
  }

}