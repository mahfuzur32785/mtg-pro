import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../data/enums/state_status.dart';
import '../../repository/setting_pages_repository.dart';

class SuggestFeatureController extends GetxController {
  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;
  SuggestFeatureController(this._loginController,this._settingsPagesRepository);
  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  final formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();

  @override
  void onInit() {
    //todo apply........
    super.onInit();
  }

  void postSuggestFeature() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final body = <String,dynamic>{};
    body.addAll({"message": messageController.text.trim()});

    final result = await _settingsPagesRepository.postSuggestFeature(body, token);

    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      Helper.toastMsg(error.message);
    }, (data) async {
      _stateStatusRx.value = StateStatus.SUCCESS;
      Helper.toastMsg(data);
      messageController.text = '';
      await NotificationService.sendNotification([], "Thanks for the suggest a request",
          "Thanks for Suggest. We'll review it carefully and will reach out if we have any questions. \nThank you for being and MTGPRO.ME");
    });
  }
}