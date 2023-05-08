import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mtgpro/app/core/services/notification_service.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/modules/login/controller/auth_repository.dart';
import 'package:mtgpro/app/modules/login/model/user_login_response_model.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../core/utils/my_sharedpreferences.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  LoginController(this._authRepository);

  var isLoading = false.obs;

  Client client = Client();
  final loginKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? email;
  String? password;

  final obscureText = true.obs;
  void toggle() {
    obscureText.toggle();
    update();
  }

  UserLoginResponseModel? _user;
  bool get isLoggedIn => _user != null && _user!.accessToken.isNotEmpty;
  bool get isAvailableCard => _user!.user.cardCount > 0;
  UserLoginResponseModel? get userInfo => _user;
  set user(UserLoginResponseModel userData) => _user = userData;
  void cacheUserData() => _authRepository.saveCashedUserInfo(_user!);
  void cacheUserWithData(UserLoginResponseModel userData) => _authRepository.saveCashedUserInfo(userData);

  @override
  void onInit() {
    /// set user data if usre already login
    final result = _authRepository.getCashedUserInfo();
    result.fold(
          (l) => _user = null,
          (r) {
        user = r;
      },
    );
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void login() async {
    List<String> ids = await NotificationService.getDeviceId();
    var token = ids.isEmpty ? "" : ids.first;
    final body = <String,String>{};
    body.addAll({"email": emailController.text.trim()});
    body.addAll({"password": passwordController.text.trim()});
    body.addAll({"device_token": token});
    // Utils.loadingDialog(Get.context!);
    isLoading.value = true;
    final result = await _authRepository.login(body);

    result.fold((error) {
      // Utils.closeDialog(Get.context!);
      isLoading.value = false;
      if (kDebugMode) {
        print(error.message);
      }
      Get.snackbar('Error', error.message);
    }, (data) async {
      isLoading.value = false;
      _user = data;
      // Utils.closeDialog(Get.context!);
      if (kDebugMode) {
        print(data);
      }
      if (data.user.cardCount > 0) {
        Get.offAndToNamed(Routes.home);
      } else {
        Get.offAndToNamed(Routes.stepVCardsName);
      }
      // Utils.showSnackBar(Get.context!, data);
    });
  }

}