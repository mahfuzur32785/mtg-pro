import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/login/model/user_login_response_model.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../login/controller/auth_repository.dart';
import '../../login/login_controller.dart';
import '../../login/model/user_prfile_model.dart';
import 'create_step_card_repository.dart';

class CreateStepVcardController extends GetxController{
  final CreateStepCardRepository _createStepCardRepository;
  final LoginController _loginController;
  CreateStepVcardController(this._createStepCardRepository, this._loginController);
  var isLoading = false.obs;
  var btnLoader = false.obs;

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

  // ............ name ................
  final nameFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  // ............ company .............
  final companyFormKey = GlobalKey<FormState>();
  var designationController = TextEditingController();
  var companyController = TextEditingController();

  // ............ photo ...............
  String? originalImage;
  String? image;
  String? base64Image;
  Future<void> chooseImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        CroppedFile? file = await Utils.cropper(value,1.0,1.0);
        if (file != null) {
          image = file.path;
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
      image = file.path;
      List<int> imageBytes = await file.readAsBytes();
      base64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
    }
    update();
  }
  void deleteImage(){
    originalImage = null;
    image = null;
    base64Image = null;
    update();
  }

  void stepCardCreate() async {
    if (!_loginController.isLoggedIn) {
      Helper.toastMsg("Please Login!");
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    final body = <String,String>{};
    body.addAll({"name": nameController.text.trim()});
    body.addAll({"phone_number": phoneController.text.trim()});
    body.addAll({"designation": designationController.text.trim()});
    body.addAll({"company_name": companyController.text.trim()});
    body.addAll({"photo": '$base64Image'});
    // Utils.loadingDialog(Get.context!);
    btnLoader.value = true;
    final result = await _createStepCardRepository.createStepCard(body,token);
    result.fold((error) {
      // Utils.closeDialog(Get.context!);
      btnLoader.value = false;
      Get.snackbar('Error', error.message);
    }, (data) async {
      // Utils.closeDialog(Get.context!);
      btnLoader.value = false;
      _loginController.user = UserLoginResponseModel(user: getUserData(), accessToken: _loginController.userInfo!.accessToken);
      _loginController.cacheUserData();
      Helper.toastMsg(data);
      Get.offAllNamed(Routes.home);
    });
  }

  UserProfileModel getUserData() {
    return UserProfileModel(
      id: _loginController.userInfo!.user.id,
      email: _loginController.userInfo!.user.email,
      status: _loginController.userInfo!.user.status,
      createdAt: _loginController.userInfo!.user.createdAt,
      updatedAt: _loginController.userInfo!.user.updatedAt,
      name: _loginController.userInfo!.user.name,
      profileImage: _loginController.userInfo!.user.profileImage,
      username: _loginController.userInfo!.user.username,
      billingCity: _loginController.userInfo!.user.billingCity,
      billingCountry: _loginController.userInfo!.user.billingCountry,
      billingCountryCode: _loginController.userInfo!.user.billingCountryCode,
      billingState: _loginController.userInfo!.user.billingState,
      billingZipcode: _loginController.userInfo!.user.billingZipcode,
      cardCount: 1,
      dob: _loginController.userInfo!.user.dob,
      gender: _loginController.userInfo!.user.gender,
      planActivationDate: _loginController.userInfo!.user.planActivationDate,
      planDetails: _loginController.userInfo!.user.planDetails,
      planId: _loginController.userInfo!.user.planId,
      planValidity: _loginController.userInfo!.user.planValidity,
      provider: _loginController.userInfo!.user.provider,
      roleId: _loginController.userInfo!.user.roleId,
      socialId: _loginController.userInfo!.user.socialId,
      term: _loginController.userInfo!.user.term,
      userType: _loginController.userInfo!.user.userType,
      userDisclaimer: _loginController.userInfo!.user.userDisclaimer,
      housingLogoView: _loginController.userInfo!.user.housingLogoView,
      disclaimerView: _loginController.userInfo!.user.disclaimerView,
      formView: _loginController.userInfo!.user.formView,
      creditAuthorization: _loginController.userInfo!.user.creditAuthorization,
      nmlsId: _loginController.userInfo!.user.nmlsId,
      nmlsView: _loginController.userInfo!.user.nmlsView,
      quickApplication: _loginController.userInfo!.user.quickApplication,
    );
  }

  // ............ email ...............

  // ............ phone ...............

  // ............ password ............
}