import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/review/model/review_model.dart';

import '../../core/utils/helpers.dart';
import '../../core/utils/utils.dart';
import '../../data/enums/state_status.dart';
import '../login/login_controller.dart';
import '../settings_pages/repository/setting_pages_repository.dart';

class ReviewController extends GetxController {

  ReviewController(this._settingsPagesRepository, this._loginController);

  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  String get profileUrl => _loginController.userInfo!.user.profileImage;

  var errorText = ''.obs;
  ReviewModel? reviewModel;

  var btnLoading = false.obs;
  var isForm  = false.obs;
  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var titleController = TextEditingController();
  var reviewController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getReviewData();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void changeBtnLoading(value){
    btnLoading.value = value;
    update();
  }
  void changeIsForm(value){
    print(",,,,,,,,,,,,,,,,,,,,");
    isForm.value = value;
    update();
  }

  void readyToUpdate() {
    nameController.text = '${reviewModel?.displayName}';
    titleController.text = '${reviewModel?.displayTitle}';
    reviewController.text = '${reviewModel?.details}';
    isForm.value = true;
    update();
  }

  void getReviewData() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _settingsPagesRepository.getReview(token);
    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      errorText.value = error.message;
      changeIsForm(true);
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      reviewModel = data;
    });
  }

  void postAReview() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    // _stateStatusRx.value = StateStatus.LOADING;
    final body = <String,dynamic>{};
    body.addAll({"display_name": nameController.text.trim()});
    body.addAll({"display_title": titleController.text.trim()});
    body.addAll({"details": reviewController.text.trim()});
    print(body.toString());

    final token = _loginController.userInfo!.accessToken;

    Utils.loadingDialog(Get.context!);

    final result = await _settingsPagesRepository.postReview(body, token);

    result.fold((error) {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) {
      Utils.closeDialog(Get.context!);
      reviewModel = data;
      changeIsForm(false);
    });
  }


  void updateAReview() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    final body = <String,dynamic>{};
    body.addAll({"display_name": nameController.text.trim()});
    body.addAll({"display_title": titleController.text.trim()});
    body.addAll({"details": reviewController.text.trim()});
    print(body.toString());

    final token = _loginController.userInfo!.accessToken;
    final id = reviewModel!.id.toString();
    Utils.loadingDialog(Get.context!);

    final result = await _settingsPagesRepository.updateReview(body, token, id);

    result.fold((error) {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) {
      Utils.closeDialog(Get.context!);
      reviewModel = data;
      changeIsForm(false);
    });
  }

}