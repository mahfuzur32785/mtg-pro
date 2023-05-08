import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/notification_service.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../settings_pages/repository/setting_pages_repository.dart';

class ForgotPasswordController extends GetxController {
  final SettingsPagesRepository _settingsPagesRepository;
  ForgotPasswordController(this._settingsPagesRepository);
  var isLoading = false.obs;

  var emailController = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void resetPasswordLink() async {
    isLoading.value = true;
    final result = await _settingsPagesRepository.forgotPasswordLink(emailController.text.trim());

    result.fold((error) {
      // _stateStatusRx.value = StateStatus.FAILURE;
      isLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) async {
      // _stateStatusRx.value = StateStatus.SUCCESS;
      isLoading.value = false;
      Helper.toastMsg(data);
      await NotificationService.sendNotification([], "Password Reset - MTGPRO.ME", "We have sent a password reset link to ${emailController.text.trim()}. Please check");
    });
  }
}