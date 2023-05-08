import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/data/models/social_media_model.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../../core/utils/utils.dart';
import 'card_create_repository.dart';

class MtgCreateCardController extends GetxController {
  final LoginController _loginController;
  final CardCreateRepository _cardCreateRepository;
  MtgCreateCardController(this._loginController,this._cardCreateRepository);
  var isLoading = false.obs;
  final key = GlobalKey<FormState>();

  var cardNameController = TextEditingController();

  var fullNameController = TextEditingController().obs;
  var locationController = TextEditingController();
  var companyController = TextEditingController();
  var jobTitleController = TextEditingController();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var maidenNameController = TextEditingController();
  var bioController = TextEditingController();

  var selectedColor = 0.obs;
  void changeColor(index){
    selectedColor(index);
  }

  List<Color> colorList = [
    const Color(0xffeaeaea),
    const Color(0xff000000),
    const Color(0xffEB5757),
    const Color(0xffF2994A),
    const Color(0xffF2C94C),
    const Color(0xff219653),
    const Color(0xff2F80ED),
    const Color(0xff9B51E0),
  ];

  var isColoredIcons = false.obs;
  void changeIsColoredIcons(value){
    isColoredIcons(value);
  }

  var socialLinks = <SocialMedias>[].obs;
  void addSocialLinks(SocialMedias socialMedia){
    socialLinks.add(socialMedia);
  }

  //.............. Images ...................
  //...... cover
  String? originalCoverImage;
  var coverImage = ''.obs;
  String? coverBase64Image;
  Future<void> chooseCoverImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalCoverImage = value;
        CroppedFile? file = await Utils.cropper(value,5.0,2.0);
        if (file != null) {
          coverImage.value = file.path;
          List<int> imageBytes = await file.readAsBytes();
          coverBase64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
        }
      }
    });
    update();
  }
  //...... cover
  String? originalProfileImage;
  var profileImage = ''.obs;
  String? profileBase64Image;
  Future<void> chooseProfileImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalProfileImage = value;
        CroppedFile? file = await Utils.cropper(value,1.0,1.0);
        if (file != null) {
          profileImage.value = file.path;
          List<int> imageBytes = await file.readAsBytes();
          profileBase64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
        }
      }
    });
    update();
  }
  //...... cover
  String? originalLogoImage;
  var logoImage = ''.obs;
  String? logoBase64Image;
  Future<void> chooseLogoImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalLogoImage = value;
        CroppedFile? file = await Utils.cropper(value,1.0,1.0);
        if (file != null) {
          logoImage.value = file.path;
          List<int> imageBytes = await file.readAsBytes();
          logoBase64Image = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
        }
      }
    });
    update();
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


  void createCard() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;

    final body = <String, dynamic>{};
    body.addAll({"name": firstNameController.text.trim()});
    body.addAll({"location": locationController.text.trim()});
    body.addAll({"designation": jobTitleController.text.trim()});
    body.addAll({"company_name": companyController.text.trim()});
    body.addAll({"color_link": '${isColoredIcons.value}'});
    // body.addAll({"phone_number": '01860141942'});
    body.addAll({"profile_pic": profileBase64Image});
    body.addAll({"cover_pic": coverBase64Image});
    body.addAll({"company_logo": logoBase64Image});
    body.addAll({"bgcolor": '#${colorList[selectedColor.value].value.toRadixString(16).substring(2)}'});
    body.addAll({"bio": bioController.text.trim()});

    isLoading.value = true;
    final result = await _cardCreateRepository.createCard(body, token);
    result.fold((error) {
      isLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isLoading.value = false;
      clearField();
      Helper.toastMsg("Successfully created a card");
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.toNamed(Routes.mtgCardEdit,arguments: data);
      });
      // showDialog(
      //     context: Get.context!,
      //     builder: (_) => AlertDialog(
      //       content: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               const Icon(Icons.check_circle, color: Colors.green,),
      //               Text(data),
      //             ],
      //           ),
      //         ],
      //       ),
      //     )
      // );
    });

  }


  void clearField(){
    firstNameController.text = '';
    locationController.text = '';
    jobTitleController.text = '';
    companyController.text = '';
    bioController.text = '';
    coverImage.value = '';
    profileImage.value = '';
    logoImage.value = '';
  }

}