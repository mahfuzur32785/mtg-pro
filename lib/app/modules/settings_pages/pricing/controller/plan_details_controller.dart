import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/model/plan_model.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../../data/enums/state_status.dart';

class PlanDetailsController extends GetxController{
  final LoginController _loginController;
  PlanDetailsController(this._loginController);
  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var isLoading = false.obs;

  var errorText = ''.obs;

  List<Country> allCountry = countries;
  String countryCode = '880';
  void changeCountryCode(value){
    countryCode = value;
  }
  var selectedFlag = ''.obs;
  void changeFlag(String value){
    selectedFlag.value = value;
  }

  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var billingAddressController = TextEditingController();
  var billingCityController = TextEditingController();
  var billingStateController = TextEditingController();
  var billingZipCodeController = TextEditingController();
  var billingCountryController = TextEditingController();
  var billingPhoneController = TextEditingController();

  PricingPlanModel? planModel;
  int? isYearly;

  @override
  void onInit() {
    var arguments = Get.arguments;
    planModel = arguments["plan"];
    isYearly = arguments["isYearly"];
    emailController.text = '${_loginController.userInfo?.user.email}';
    nameController.text = '${_loginController.userInfo?.user.name}';
    billingCityController.text = '${_loginController.userInfo?.user.billingCity}';
    billingStateController.text = '${_loginController.userInfo?.user.billingState}';
    billingCountryController.text = '${_loginController.userInfo?.user.billingCountry}';
    billingZipCodeController.text = '${_loginController.userInfo?.user.billingZipcode}';
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  String getPlanType(){
    return isYearly == 1 ? "1 Year" : '1 Month';
  }
  int getMainPrice(){
    if (planModel!.isFree == 1) {
      return 0;
    }
    if (isYearly == 1) {
      return planModel!.planPriceYearly;
    } else {
      return planModel!.planPriceMonthly;
    }
  }
  double getDiscountPrice(){
    if (planModel!.isFree == 1) {
      return 0.0;
    }

    if (planModel!.discountPercentage == 0) {
      if (isYearly == 1) {
        return planModel!.planPriceYearly.toDouble();
      } else {
        return planModel!.planPriceMonthly.toDouble();
      }
    } else {
      if (isYearly == 1) {
        return ((planModel!.planPriceYearly / 100) * (100 - planModel!.discountPercentage)).toDouble();
      } else {
        return ((planModel!.planPriceMonthly / 100) * (100 - planModel!.discountPercentage)).toDouble();
      }
    }
  }

  void makePaymentData(){
    final body = <String, dynamic>{};
    body.addAll({"plan_id": '${planModel?.id}'});
    body.addAll({"billing_name": nameController.text.trim()});
    body.addAll({"billing_address": billingAddressController.text.trim()});
    body.addAll({"billing_city": billingCityController.text.trim()});
    body.addAll({"billing_state": billingStateController.text.trim()});
    body.addAll({"billing_zipcode": billingZipCodeController.text.trim()});
    body.addAll({"billing_country": billingCountryController.text.trim()});
    body.addAll({"billing_phone": '$countryCode${billingPhoneController.text.trim()}'});
    body.addAll({"billing_email": emailController.text.trim()});
    body.addAll({"is_yearly": '$isYearly'});
    body.addAll({"cost": '${planModel?.cost}'});
    body.addAll({"plan_name": '${planModel?.name}'});

    Get.toNamed(Routes.stripeScreen,arguments: body);
  }
}