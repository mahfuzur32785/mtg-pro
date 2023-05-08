import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mtgpro/app/modules/vcard_to_crm/controller/vcard_to_crm_repository.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/routes.dart';
import '../../login/login_controller.dart';

class VCardToCrmController extends GetxController {
  final LoginController _loginController;
  final VCardToCrmRepository _repository;
  VCardToCrmController(this._repository,this._loginController);

  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var companyController = TextEditingController();
  var jobTitleController = TextEditingController();

  RecognizedText? recognizedText;

  @override
  void onInit() {
    // if (isPhoneNumber("+8801860141942")) {
    //   phoneController.text = '+8801860141942';
    // }
    var arguments = Get.arguments;
    if (arguments != null) {
      recognizedText = arguments;
    }
    loadData();
    super.onInit();
  }

  @override
  void onClose() {

    super.onClose();
  }

  void saveToCrm() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;

    final body = <String, dynamic>{};
    body.addAll({"name": nameController.text.trim()});
    body.addAll({"address": addressController.text.trim()});
    body.addAll({"job_title": jobTitleController.text.trim()});
    body.addAll({"company": companyController.text.trim()});
    body.addAll({"phone": phoneController.text.trim()});
    body.addAll({"email": emailController.text.trim()});

    isLoading.value = true;
    final result = await _repository.saveToCrm(body, token);
    result.fold((error) {
      isLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isLoading.value = false;
      clearField();
      Helper.toastMsg("Successfully import the card");
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Navigator.pop(Get.context!);
        Get.toNamed(Routes.crmScreen);
      });
    });

  }

  void clearField(){
    nameController.text = '';
    addressController.text = '';
    jobTitleController.text = '';
    companyController.text = '';
    emailController.text = '';
    phoneController.text = '';
  }

  void loadData() async {
    // recognizedText!.blocks.map((e) {
    //     var xx = e.text.replaceAll(" ", "");
    //     if (isPhoneNumber(xx)) {
    //       print("xxxxxxxxxx number $xx xxxxxxxxxxx");
    //       phoneController.text = xx;
    //     }
    // }).toList();

    print(recognizedText!.text);

    for(TextBlock textBlock in recognizedText!.blocks){
      if (GetUtils.isEmail(textBlock.text)) {
        print("xxxxxxxxxx email ${textBlock.text} xxxxxxxxxxx");
        emailController.text = textBlock.text;
      }
      var xx = textBlock.text.replaceAll(" ", "").split("+").last;
      if (isPhoneNumber(xx)) {
        print("xxxxxxxxxx phone ${xx} xxxxxxxxxxx");
        phoneController.text = xx;
      }

      // var xx = textBlock.text.replaceAll(" ", "");
      // if (isPhoneNumber(xx)) {
      //   print("xxxxxxxxxx number $xx xxxxxxxxxxx");
      //   phoneController.text = xx;
      // }

      if (isFullName(textBlock.text)) {
        print("xxxxxxxxxx name ${textBlock.text} xxxxxxxxxxx");
        nameController.text = textBlock.text;
      }
      if (isAddress(textBlock.text)) {
        print("xxxxxxxxxx address ${textBlock.text} xxxxxxxxxxx");
        addressController.text = textBlock.text;
      }

      // if (GetUtils.is(textBlock.text)) {
      //   print("xxxxxxxxxx name ${textBlock.text} xxxxxxxxxxx");
      //   jobTitleController.text = textBlock.text;
      // }
      // print(textBlock.text);
    }
    update();
  }

  bool isPhoneNumber(String s) {
    if (s.length > 30 || s.length < 9) return false;
    print("$s");
    bool b = hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    print(" hhhhhhhhhhhh $b hhhhhhhhhhh");
    return b;
  }

  bool isAddress(String s) {
    return hasMatch(s, r'^\s*\S+(?:\s+\S+){2}');
  }

  bool isFullName(String s){
    return hasMatch(s, r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  }

  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

}