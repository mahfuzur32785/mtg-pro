import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/marketing_material/model/market_model.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/enums/state_status.dart';
import '../../../../data/remote_urls.dart';
import '../../../login/login_controller.dart';
import '../../repository/setting_pages_repository.dart';

class MarketingController extends GetxController {

  MarketingController(this._settingsPagesRepository, this._loginController);

  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var isLoadMoreLoading = false.obs;

  var errorText = ''.obs;
  var marketMaterial = <MarketMaterialModel>[].obs;
  MarketMaterialResponseModel? materialResponseModel;

  final scrollController = ScrollController();

  @override
  void onInit() {
    getMarketMaterialList();
    super.onInit();
    _init();
  }
  void _init() {
    scrollController.addListener(() {
      final maxExtent = scrollController.position.maxScrollExtent - 100;
      if (maxExtent < scrollController.position.pixels) {
        getMarketMaterialMore();
      }
    });
  }

  void getMarketMaterialList() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    final url = Uri.parse(RemoteUrls.getMarketMaterial);

    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _settingsPagesRepository.getMarketMaterial(url,token);
    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      errorText.value = error.message;
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      materialResponseModel = data;
      // marketMaterial.value = data.data;
      marketMaterial.value.addAll(data.data);
      marketMaterial.value.addAll(data.data);
      marketMaterial.value.addAll(data.data);
    });
  }

  void getMarketMaterialMore() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    if (materialResponseModel == null ||
        materialResponseModel?.nextPageUrl == null) {
      return;
    }

    Uri url = Uri.parse(materialResponseModel?.nextPageUrl);

    final token = _loginController.userInfo!.accessToken;
    isLoadMoreLoading.value = true;
    final result = await _settingsPagesRepository.getMarketMaterial(url,token);
    result.fold((error) {
      isLoadMoreLoading.value = false;
    }, (data) {
      isLoadMoreLoading.value = false;
      materialResponseModel = data;
      marketMaterial.addAll(data.data);
    });
  }

}