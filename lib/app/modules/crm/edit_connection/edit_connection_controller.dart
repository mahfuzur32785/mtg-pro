import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mtgpro/app/modules/crm/view_connection/model/veiw_connection_model.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../../data/enums/state_status.dart';
import '../../login/login_controller.dart';
import '../../settings_pages/repository/setting_pages_repository.dart';

class EditConnectionController extends GetxController {

  EditConnectionController(this._settingsPagesRepository, this._loginController);

  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  CrmDetailsModel? crmDetailsModel;

  var profileUrl = ''.obs;
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var jobTitleController = TextEditingController();
  var companyNameController = TextEditingController();
  var descriptionController = TextEditingController();

  final obscureText = true.obs;
  var errorText = ''.obs;

  final isSuccess = false.obs;


  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    /// set user data if usre already login
    super.onInit();

    print("userId ${argumentData[0]}");

    nameController.text = argumentData[1];
    emailController.text = argumentData[2];
    phoneController.text = argumentData[3];
    jobTitleController.text = argumentData[4];
    companyNameController.text = argumentData[5];
    descriptionController.text = argumentData[6];
    profileUrl.value = argumentData[7];
    // getCrmDetails(int.parse(argumentData[0]));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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

  /*void getCrmDetails(id) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _settingsPagesRepository.getCRMDetails( token , id );
    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      errorText.value = error.message;
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      nameController.text = data.name!;
      emailController.text = data.email!;
      phoneController.text = data.phone!;

      crmDetailsModel = data;
    });
  }*/

Future<void> updateCrmDetails(id) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    if(base64Image == null){
      Helper.toastMsg("Please select Image");
      return;
    }
    // _stateStatusRx.value = StateStatus.LOADING;
    final body = <String,dynamic>{};
    body.addAll({"name": nameController.text.trim()});
    body.addAll({"email": emailController.text.trim()});
    body.addAll({"phone": phoneController.text.trim()});
    body.addAll({"title": jobTitleController.text.trim()});
    body.addAll({"company_name": companyNameController.text.trim()});
    body.addAll({"message": descriptionController.text.trim()});
    body.addAll({"profile_pic": base64Image ?? ''});

    print(body.toString());

    final token = _loginController.userInfo!.accessToken;

    Utils.loadingDialog(Get.context!);

    final result = await _settingsPagesRepository.updateCrmDetails(body, token, id);

    result.fold((error) {
      // _stateStatusRx.value = StateStatus.FAILURE;
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) {
      // _stateStatusRx.value = StateStatus.SUCCESS;
      isSuccess.value = true;
      Utils.closeDialog(Get.context!);
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        Get.back(result: [
          {"backValue": isSuccess.value}
        ]);
      });
      Helper.toastMsg(data);
    });
}

}