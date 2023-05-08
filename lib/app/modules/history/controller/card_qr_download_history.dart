import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/modules/history/model/history_view_response_model.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/enums/state_status.dart';
import '../../insights/controller/insights_repository.dart';
import '../../login/login_controller.dart';
import '../model/history_view_model.dart';

class CardQrDownloadHistoryController extends GetxController {
  final InsightsRepository _insightsRepository;
  final LoginController _loginController;
  CardQrDownloadHistoryController(this._loginController,this._insightsRepository);
  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  final scrollController = ScrollController();

  var isLoading = false.obs;
  var isLoadingMore = false.obs;

  HistoryViewResponseModel? historyViewResponseModel;
  var cardViewList = <HistoryViewModel>[].obs;

  @override
  void onInit() {
    getCardViewData();
    super.onInit();
    _init();
  }

  void _init() {
    scrollController.addListener(() {
      final maxExtent = scrollController.position.maxScrollExtent - 100;
      if (maxExtent < scrollController.position.pixels) {
        getCardViewDataMore();
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getCardViewData({bool isLoad = true}) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    isLoading.value = isLoad;

    final token = _loginController.userInfo!.accessToken;
    final uri = Uri.parse(RemoteUrls.getQrDownloadHistory);
    final result = await _insightsRepository.getCardViewHistory(uri,token);

    result.fold((error) {
      isLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isLoading.value = false;
      historyViewResponseModel = data;
      cardViewList.value = data.historyViewModel;
    });
  }

  Future<void> getCardViewDataMore() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    if (historyViewResponseModel == null ||
        historyViewResponseModel?.nextPageUrl == null) {
      return;
    }

    isLoadingMore.value = true;

    final token = _loginController.userInfo!.accessToken;
    final uri = Uri.parse(historyViewResponseModel!.nextPageUrl!);
    final result = await _insightsRepository.getCardViewHistory(uri,token);

    result.fold((error) {
      isLoadingMore.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isLoadingMore.value = false;
      historyViewResponseModel = data;
      cardViewList.addAll(data.historyViewModel);
    });
  }
}