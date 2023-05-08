import 'package:flutter/foundation.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';

import '../../core/services/notification_service.dart';
import '../../core/utils/my_sharedpreferences.dart';
import '../login/controller/auth_repository.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository;
  final LoginController _loginController;
  SignupController(this._authRepository, this._loginController);
  var isLoading = false.obs;

  Client client = Client();
  final signupKey = GlobalKey<FormState>();
  final signupComKey = GlobalKey<FormState>();

  int typeOfUser = 0;
  List<String> userType = ["Individual","Company","Agency"];
  void changeUserType(type){
    typeOfUser = type;
    update();
  }


  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String? email;
  String? name;
  String? userName;
  String? password;
  String? confirmPassword;

  //............ Company field .............
  var companyEmailController = TextEditingController();
  var companyNameController = TextEditingController();
  var contactNameController = TextEditingController();
  var designationController = TextEditingController();
  var officeAddressController = TextEditingController();
  var companyMobileController = TextEditingController();
  var companyPasswordController = TextEditingController();
  String? comEmail;
  String? companyName;
  String? comMobile;
  String? comContactName;
  String? comDesignation;
  String? companyAddress;
  String? comPassword;

  final obscureText = true.obs;
  void toggle() {
    obscureText.toggle();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void register() async {
    List<String> ids = await NotificationService.getDeviceId();
    var token = ids.isEmpty ? "" : ids.first;
    final body = <String,String>{};
    body.addAll({"username": userNameController.text.trim()});
    body.addAll({"name": nameController.text.trim()});
    body.addAll({"email": emailController.text.trim()});
    body.addAll({"password": passwordController.text.trim()});
    body.addAll({"password_confirmation": confirmPasswordController.text.trim()});
    body.addAll({"device_token": token});
    isLoading.value = true;
    final result = await _authRepository.userRegister(body);

    result.fold((error) {
      isLoading.value = false;
      Get.snackbar('Error', error.message);
    }, (data) async {
      isLoading.value = false;
      _loginController.user = data;
      Get.offAndToNamed(Routes.stepVCardsName);
    });
  }

  // ........................... OTP CODE ............................
  final pinController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.mainColor),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.mainColor),
      borderRadius: BorderRadius.circular(6),
    ),
  );

  void submitOtp(String value) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.toNamed(Routes.home);
    });
  }

}