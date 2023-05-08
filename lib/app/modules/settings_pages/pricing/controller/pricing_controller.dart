import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/model/plan_model.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';

import '../../../../data/enums/state_status.dart';

class PricingController extends GetxController{
  final SettingsPagesRepository _repository;
  PricingController(this._repository);
  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var isLoading = false.obs;

  var errorText = ''.obs;

  var isAnnual = 1.obs;
  void changePlan(value){
    isAnnual.value = value;
    update();
  }

  var plans = <PricingPlanModel>[].obs;

  var initialPage = 0.obs;
  var currentPage = 0.obs;
  void callBackFunction(int index, CarouselPageChangedReason reason){
    currentPage.value = index;
    update();
  }

  int getPrice(index){
    if (isAnnual.value == 1) {
      return plans[index].planPriceYearly;
    } else {
      return plans[index].planPriceMonthly;
    }
  }

  @override
  void onInit() {
    getPricingPlans();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getPricingPlans() async {
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _repository.getPricingPlans();
    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      errorText.value = error.message;
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      plans.value = data;
    });
  }
}