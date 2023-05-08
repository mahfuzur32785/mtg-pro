import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mtgpro/app/core/utils/extensions.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/data/enums/social_icon_type.dart';
import 'package:mtgpro/app/data/models/social_media_model.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/modules/home_cards/model/business_card_fields_model.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/modules/home_cards/model/social_link_model.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';

import '../../../core/utils/utils.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import '../../card_create/mtg_card_create/controller/card_create_repository.dart';
import '../../home_cards/controller/home_cards_controller.dart';
import '../../login/model/user_prfile_model.dart';


class MtgCardEditController extends GetxController {
  final LoginController _loginController;
  final CardCreateRepository _cardCreateRepository;
  final HomeCardsController homeCardsController;
  MtgCardEditController(this._loginController,
      this._cardCreateRepository,
      this.homeCardsController);
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

  CardModel? currentCard;

  @override
  void onInit() {
    CardModel arguments = Get.arguments as CardModel;
    currentCard = arguments;
    loadData(arguments);
    super.onInit();
    Future.microtask(() {
      quick.value = homeCardsController.userInfo?.quickApplication == 1 ? true : false;
      housingLogo.value = homeCardsController.userInfo?.housingLogoView == 1 ? true : false;
      credit.value = homeCardsController.userInfo?.creditAuthorization == 1 ? true : false;
      nmls.value = homeCardsController.userInfo?.nmlsView == 1 ? true : false;
      nmlsController.text = '${homeCardsController.userInfo?.nmlsId}';
      disclaimer.value = homeCardsController.userInfo?.disclaimerView == 1 ? true : false;
    });
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  var nmlsController = TextEditingController();
  var nmlsBtnLoading = false.obs;
  void addUserNmls() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    String nmlsId = nmlsController.text;
    nmlsBtnLoading.toggle();

    final result = await _cardCreateRepository.addUserNmls(RemoteUrls.userNmlsAdd, nmlsId, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      nmlsBtnLoading.toggle();
    }, (data) {
      Helper.toastMsg(data);
      nmlsBtnLoading.toggle();
      homeCardsController.user = updateUserData();
    });
  }

  var housingLogo = true.obs;
  void changeHousingLogo(value) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    String status = value ? "1" : "0";
    housingLogo.toggle();

    final result = await _cardCreateRepository.updateAdditionalFeature(RemoteUrls.equalHousingView, status, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      housingLogo.toggle();
    }, (data) {
      Helper.toastMsg(data);
      homeCardsController.user = updateUserData();
    });
  }

  var disclaimer = true.obs;
  void changeDisclaimer(value) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    String status = value ? "1" : "0";
    disclaimer.toggle();

    final result = await _cardCreateRepository.updateAdditionalFeature(RemoteUrls.userDisclaimerView, status, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      disclaimer.toggle();
    }, (data) {
      Helper.toastMsg(data);
      homeCardsController.user = updateUserData();
    });
  }

  var nmls = true.obs;
  void changeNmls(value)async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    String status = value ? "1" : "0";
    nmls.toggle();

    final result = await _cardCreateRepository.updateAdditionalFeature(RemoteUrls.userNmlsView, status, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      nmls.toggle();
    }, (data) {
      Helper.toastMsg(data);
      homeCardsController.user = updateUserData();
    });
  }

  var credit = true.obs;
  void changeCredit(value)async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    String status = value ? "1" : "0";
    credit.toggle();

    final result = await _cardCreateRepository.updateAdditionalFeature(RemoteUrls.userCreditAuthView, status, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      credit.toggle();
    }, (data) {
      Helper.toastMsg(data);
      homeCardsController.user = updateUserData();
    });
  }

  var quick = true.obs;
  void changeQuick(value)async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    String status = value ? "1" : "0";
    quick.toggle();

    final result = await _cardCreateRepository.updateAdditionalFeature(RemoteUrls.quickApplicationView, status, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      quick.toggle();
    }, (data) {
      Helper.toastMsg(data);
      homeCardsController.user = updateUserData();
    });
  }

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

  var socialLinks = <SocialLinkModel>[].obs;
  void addSocialLinks(SocialLinkModel socialLinkModel){
    socialLinks.add(socialLinkModel);
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

  String getCoverUrl(){
    if (currentCard == null) {
      return '';
    }
    return currentCard!.coverPicUrl;
  }
  String getProfileUrl(){
    if (currentCard == null) {
      return '';
    }
    return currentCard!.profilePicUrl;
  }
  String getLogoUrl(){
    if (currentCard == null) {
      return '';
    }
    return currentCard!.logoPicUrl;
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

  void editCard() async {
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
    body.addAll({"profile_pic": profileBase64Image ?? ''});
    body.addAll({"cover_pic": coverBase64Image ?? ''});
    body.addAll({"company_logo": logoBase64Image ?? ''});
    body.addAll({"bgcolor": '#${colorList[selectedColor.value].value.toRadixString(16).substring(2)}'});
    body.addAll({"bio": bioController.text.trim()});

    isLoading.value = true;
    final result = await _cardCreateRepository.editCard(body,currentCard!.id, token);
    result.fold((error) {
      isLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isLoading.value = false;
      // clearField();
      Get.snackbar("Message", data);
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
  void cardAddSocialToApi(SocialLinkModel socialLinkModel) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;

    final body = <String, dynamic>{};
    body.addAll({"card_id": '${currentCard!.id}'});
    body.addAll({"icon_id": '${socialLinkModel.id}'});
    body.addAll({"label": socialLinkModel.iconName});
    body.addAll({"content": socialLinkModel.mainLink});

    Utils.loadingDialog(Get.context!);

    final result = await _cardCreateRepository.cardAddIcon(body, token);
    result.fold((error) {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg("Successfully Added");
      socialLinks.add(socialLinkModel.copyWith(cardFieldId: data["data"]["id"]));
    });

  }

  Future<Either<Failure, String>> editSocialIcon(SocialLinkModel icon,) async {
    print(' field id : ${icon.cardFieldId}/ icon id : ${icon.id} / icon status: ${icon.status}');
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      throw const UnauthorisedException('Please Login Again!', 401);
    }

    final token = _loginController.userInfo!.accessToken;
    final body = <String, dynamic>{};
    body.addAll({"content": icon.mainLink});
    body.addAll({"label": icon.iconName});
    body.addAll({"status": icon.status == 1 ? 'true' : 'false'});
    body.addAll({"icon_id": '${icon.id}'});
    final result = await _cardCreateRepository.editSocialIcon(body,icon.cardFieldId,token);
    return result;
  }

  Future<Either<Failure, String>> deleteIconFromCard(int cardFieldId,) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login Again!");
      throw const UnauthorisedException('Please Login Again!', 401);
    }

    final token = _loginController.userInfo!.accessToken;
    final result = await _cardCreateRepository.deleteIconFromCard(cardFieldId,token);
    return result;
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
  void loadData(CardModel cardModel) {
    cardModel.toMap().toString().log();
    firstNameController.text = cardModel.title;
    locationController.text = cardModel.location;
    jobTitleController.text = cardModel.designation;
    companyController.text = cardModel.companyName;
    bioController.text = cardModel.bio;
    isColoredIcons.value = cardModel.colorLink == 1 ? true : false;
    selectedColor.value = cardModel.themeColor != '' ? colorList.indexOf(HexColor.fromHex(cardModel.themeColor)) : 0;
    loadIconList(cardModel);
  }
  void loadIconList(CardModel cardModel){
    List<SocialLinkModel> links = [];
    for(BusinessCardField element in cardModel.businessCardField){
      print('######## ${element.id} #########');
      SocialLinkModel link = element.socialLinkModel.copyWith(mainLink: element.content,cardFieldId: element.id,status: element.status,iconTitle: element.label,iconImage: element.iconImage);
      links.add(link);
    }
    socialLinks.addAll(links);
    for(SocialLinkModel element in socialLinks){
      print('xxxxxxxxxxx ${element.mainLink} / ${element.cardFieldId} / ${element.iconName} xxxxxxxxxxxx');
    }
  }

  List<String> socialIconTypes = [ 'username', 'number', 'mail', 'text', 'address', 'mobile', 'file', 'link' ];

  TextInputType getInputType(IconType type){
    if (type == IconType.number) {
      return TextInputType.number;
    } else if (type == IconType.mail) {
      return TextInputType.emailAddress;
    } else if (type == IconType.link) {
      return TextInputType.url;
    } else if (type == IconType.mobile) {
      return TextInputType.phone;
    }
    return TextInputType.text;
  }

  Function getValidator(IconType type){
    if (type == IconType.number) {
      return Helper.validationPhone;
    } else if (type == IconType.mail) {
      return Helper.validationEmail;
    } else if (type == IconType.link) {
      return Helper.validationLink;
    } else if (type == IconType.mobile) {
      return Helper.validationPhone;
    }
    return Helper.validationAverage;
  }

  UserProfileModel updateUserData() {
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
      cardCount: _loginController.userInfo!.user.cardCount,
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
      housingLogoView: housingLogo.value ? 1 : 0,
      disclaimerView: disclaimer.value ? 1 : 0,
      formView: _loginController.userInfo!.user.formView,
      creditAuthorization: credit.value ? 1 : 0,
      nmlsId: nmlsController.text,
      nmlsView: nmls.value ? 1 : 0,
      quickApplication: quick.value ? 1 : 0,
    );
  }

}