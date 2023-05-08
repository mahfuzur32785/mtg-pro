import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/modules/login/model/user_login_response_model.dart';
import 'package:mtgpro/app/modules/login/model/user_prfile_model.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/model/billing_info_model.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/model/invoice_model.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/model/plan_model.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../data/enums/state_status.dart';
import '../../../../data/error/failure.dart';

class SubscriptionController extends GetxController {
  final SettingsPagesRepository _repository;
  final LoginController _loginController;
  SubscriptionController(this._loginController,this._repository,);

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;
  UserLoginResponseModel? get userInfo => _loginController.userInfo;

  var errorText = ''.obs;
  PricingPlanModel? currentPlan;

  // user plan
  final _planStateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get planStateStatus => _planStateStatusRx.value;
  var planErrorText = ''.obs;

  // billing info
  List<Country> allCountry = countries;
  final _billingStateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get billingStateStatus => _billingStateStatusRx.value;
  var billingErrorText = ''.obs;
  BillingInfoModel? billingInfoModel;
  var billingCountryController = TextEditingController(text: "Bangladesh");
  var billingEmailController = TextEditingController(text: "");
  var billingZipCodeController = TextEditingController(text: "");

  var billingEmail = ''.obs;
  var billingCountry = ''.obs;
  var billingZipCode = ''.obs;

  // invoice
  final _invoiceStateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get invoiceStateStatus => _planStateStatusRx.value;
  var invoiceErrorText = ''.obs;
  List<InvoiceModel> invoiceList = [];

  @override
  void onInit() {
    getInvoices();
    getUserCurrentPlan();
    getBillingInfo();
    super.onInit();
  }

  String getPrice(){
    if (currentPlan!.packageType.toLowerCase().contains("yearly")) {
      return '${currentPlan?.planPriceYearly}/${currentPlan?.packageType}';
    } else {
      return '${currentPlan?.planPriceMonthly}/${currentPlan?.packageType}';
    }
  }

  void getInvoices() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    _invoiceStateStatusRx.value = StateStatus.LOADING;
    final token = _loginController.userInfo!.accessToken;

    final result = await _repository.getInvoices(RemoteUrls.getInvoices,token);

    result.fold((error) {
      errorText.value = error.message;
      _invoiceStateStatusRx.value = StateStatus.FAILURE;
      Helper.toastMsg(error.message);
    }, (data) {
      invoiceList = data;
      _invoiceStateStatusRx.value = StateStatus.SUCCESS;
    });
  }

  void getUserCurrentPlan() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    _planStateStatusRx.value = StateStatus.LOADING;
    final token = _loginController.userInfo!.accessToken;

    final result = await _repository.getUserCurrentPlan(token);

    result.fold((error) {
      errorText.value = error.message;
      _planStateStatusRx.value = StateStatus.FAILURE;
      Helper.toastMsg(error.message);
    }, (data) {
      currentPlan = data;
      _planStateStatusRx.value = StateStatus.SUCCESS;
    });
  }
  void cancelPlan() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    Utils.loadingDialog(Get.context!);
    final token = _loginController.userInfo!.accessToken;

    final result = await _repository.cancelPlan(token);

    result.fold((error) {
      Utils.closeDialog(Get.context!);
      errorText.value = error.message;
      Helper.toastMsg(error.message);
    }, (data) async {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(data);
      getUserCurrentPlan();
      await NotificationService.sendNotification([], "Cancelled Plan",
          "Successfully cancelled your current plan.");
    });
  }

  void getBillingInfo() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    _billingStateStatusRx.value = StateStatus.LOADING;
    final token = _loginController.userInfo!.accessToken;

    final result = await _repository.getBillingInfo(token);

    result.fold((error) {
      billingErrorText.value = error.message;
      billingCountry.value = billingCountryController.text;
      _billingStateStatusRx.value = StateStatus.FAILURE;
      // Helper.toastMsg(error.message);
    }, (data) {
      billingInfoModel = data;
      billingCountry.value = billingCountryController.text = data.data.billingCountry;
      billingEmail.value = billingEmailController.text = data.data.billingEmail;
      billingZipCode.value = billingZipCodeController.text = data.data.billingZipcode;
      _billingStateStatusRx.value = StateStatus.SUCCESS;
    });
  }
  void updateBillingInfo(String email,String country, String zipcode) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    final token = _loginController.userInfo!.accessToken;
    
    final body = <String,dynamic>{};
    body.addAll({"billing_email": email});
    body.addAll({"billing_country": country});
    body.addAll({"billing_zipcode": zipcode});
    
    Utils.loadingDialog(Get.context!);
    
    final result = await _repository.postBillingUpdate(body, token);
    result.fold((error) {
      Utils.closeDialog(Get.context!);
      Helper.toastMsg(error.message);
    }, (data) {
      billingCountry.value = billingCountryController.text = country;
      billingZipCode.value = billingZipCodeController.text = zipcode;
      billingEmail.value = billingEmailController.text = email;
      UserLoginResponseModel responseModel = _loginController.userInfo!;
      UserProfileModel user = _loginController.userInfo!.user;
      user = user.copyWith(
        email: email,
        billingCountry: country,
        billingZipcode: zipcode,
      );
      responseModel = responseModel.copyWith(user: user);
      _loginController.cacheUserWithData(responseModel);
      _loginController.user = responseModel;
      Utils.closeDialog(Get.context!);
      _billingStateStatusRx.value = StateStatus.SUCCESS;
      Helper.toastMsg("Successfully Updated");
    });
  }

  void pageRefresh() async {
    getUserCurrentPlan();
    getBillingInfo();
    getInvoices();
  }

  Future<Either<Failure, String>> downloadFile(String url, String fileName,String format) async {
    final result = await _repository.downloadFile(url, fileName,format);
    return result;
  }

}