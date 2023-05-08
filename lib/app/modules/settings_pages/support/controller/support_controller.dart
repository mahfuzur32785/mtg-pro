import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/enums/state_status.dart';

class SupportController extends GetxController {
  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;
  SupportController(this._settingsPagesRepository,this._loginController);


  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var btnLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  var subjectController = TextEditingController();
  var messageController = TextEditingController();

  @override
  void onInit() {
    //todo apply
    super.onInit();
  }

  void changeBtnLoading(value){
    btnLoading.value = value;
  }

  void postSupport() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    // _stateStatusRx.value = StateStatus.LOADING;
    changeBtnLoading(true);
    final body = <String,dynamic>{};
    body.addAll({"subject": subjectController.text.trim()});
    body.addAll({"message": messageController.text.trim()});

    final token = _loginController.userInfo!.accessToken;

    final result = await _settingsPagesRepository.postSupportSubmit(body, token);

    result.fold((error) {
      // _stateStatusRx.value = StateStatus.FAILURE;
      changeBtnLoading(false);
      Helper.toastMsg(error.message);
    }, (data) {
      // _stateStatusRx.value = StateStatus.SUCCESS;
      changeBtnLoading(false);
      Helper.toastMsg(data);
      subjectController.text = '';
      messageController.text = '';
    });
  }
}