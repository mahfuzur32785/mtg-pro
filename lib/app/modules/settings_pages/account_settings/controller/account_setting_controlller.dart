import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/account_settings/model/profile_model.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';
import 'package:mtgpro/app/modules/splash/controller/app_setting_repository.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/utils.dart';
import '../../../../data/enums/state_status.dart';
import '../../../home_cards/controller/home_cards_controller.dart';

class AccountSettingController extends GetxController {
  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;
  final HomeCardsController _homeCardsController;
  AccountSettingController(this._loginController,this._settingsPagesRepository, this._homeCardsController);
  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var notification = false.obs;

  ProfileModel? profileModel;
  var profileUrl = ''.obs;
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var connectionTitleController = TextEditingController();
  var textAreaController = TextEditingController();

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void getData() async {
    _stateStatusRx.value = StateStatus.LOADING;
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _stateStatusRx.value = StateStatus.SUCCESS;
    });
  }


  // ............ photo ...............
  String? originalImage;
  var image = ''.obs;
  String? base64Image = '';
  Future<void> chooseImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        CroppedFile? file = await Utils.cropper(value,1.0,1.0);
        if (file != null) {
          image.value = file.path;
          List<int> imageBytes = await file.readAsBytes();
          base64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
        }
      }
    });
    update();
  }

  void editImage() async {
    CroppedFile? file = await Utils.cropper(originalImage,1.0,1.0);
    if (file != null) {
      image.value = file.path;
      List<int> imageBytes = await file.readAsBytes();
      base64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
    }
    update();
  }
  void deleteImage(){
    originalImage = null;
    image.value = '';
    base64Image = null;
    update();
  }

  void getProfile() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _settingsPagesRepository.getProfileData(token);
    result.fold((l) {
      _stateStatusRx.value = StateStatus.FAILURE;
      Helper.toastMsg(l.message);
    }, (data) {
      emailController.text = data.email;
      usernameController.text = data.username;
      connectionTitleController.text = data.connectionTitle;
      textAreaController.text = data.userDisclaimer;
      profileUrl.value = data.profileImage;
      profileModel = data;
      notification.value = data.isNotify == 1 ? true : false;
      _homeCardsController.user = _homeCardsController.userInfo!.copyWith(userDisclaimer: data.userDisclaimer);
      _stateStatusRx.value = StateStatus.SUCCESS;
    });
  }

  void updateProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    // _stateStatusRx.value = StateStatus.LOADING;
    final body = <String,dynamic>{};
    body.addAll({"email": emailController.text.trim()});
    body.addAll({"connection_title": connectionTitleController.text.trim()});
    body.addAll({"user_disclaimer": textAreaController.text.trim()});
    body.addAll({"profile_pic": base64Image?? ''});
    print(body.toString());

    final token = _loginController.userInfo!.accessToken;

    Utils.loadingDialog(Get.context!);

    final result = await _settingsPagesRepository.postUpdateProfile(body, token);

    result.fold((error) {
      // _stateStatusRx.value = StateStatus.FAILURE;
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) {
      // _stateStatusRx.value = StateStatus.SUCCESS;
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(data["message"]);
      _homeCardsController.user = _homeCardsController.userInfo!.copyWith(profileImage: "${data["data"]["profile_image"]}",email: emailController.text.trim(),userDisclaimer: textAreaController.text.trim());
      _loginController.user = _loginController.userInfo!.copyWith(user: _loginController.userInfo!.user.copyWith(profileImage: "${data["data"]["profile_image"]}",email: emailController.text.trim(),userDisclaimer: textAreaController.text.trim()));
      _loginController.cacheUserWithData(_loginController.userInfo!);
    });
  }

  void postIsNotify() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      notification.toggle();
      return;
    }

    final body = <String, dynamic>{};
    body.addAll({"current_val": '${notification.value}'});

    final token = _loginController.userInfo!.accessToken;

    final result = await _settingsPagesRepository.postIsNotify(body,token);

    result.fold((error) {
      notification.toggle();
      Helper.toastMsg(error.message);
    }, (data) {
      Helper.toastMsg(data);
    });
  }

  void resetPasswordLink() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;

    Utils.loadingDialog(Get.context!);

    final result = await _settingsPagesRepository.resetPasswordLink(token);

    result.fold((error) {
      // _stateStatusRx.value = StateStatus.FAILURE;
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) async {
      // _stateStatusRx.value = StateStatus.SUCCESS;
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(data);
      await NotificationService.sendNotification([], "Password Reset - MTGPRO.ME", "We have sent a password reset link to ${_loginController.userInfo?.user.email}. Please check");
    });
  }

  void deleteAccount() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    // _stateStatusRx.value = StateStatus.LOADING;
    final body = <String,dynamic>{};
    body.addAll({"confirm": 'delete'});

    final token = _loginController.userInfo!.accessToken;

    Utils.loadingDialog(Get.context!);

    final result = await _settingsPagesRepository.deleteAccount(body, token);

    result.fold((error) {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) async {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(data);
      await NotificationService.sendNotification([], "Password Reset - MTGPRO.ME", "It’s sad to see you go. As requested, your account has been deleted. No further action on your part is required. Thanks for visiting MTGPRO.ME");
      Future.delayed(const Duration(seconds: 1)).then((value) {
        MySharedPreference.clearAll();
        Get.offAllNamed(Routes.login);
      });
    });
  }

}