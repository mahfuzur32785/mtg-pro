import 'package:get/get.dart';
import 'package:mtgpro/app/modules/insights/controller/insights_repository.dart';
import 'package:mtgpro/app/modules/insights/model/insights_model.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';

import '../../../core/utils/helpers.dart';

class InsightsController extends GetxController {
  final InsightsRepository _insightsRepository;
  final LoginController _loginController;
  InsightsController(this._insightsRepository,this._loginController);

  var isLoading = false.obs;

  InsightsModel? _insightsData;
  InsightsModel? get insights => _insightsData;
  set insightsData(InsightsModel data) => _insightsData = data;

  @override
  void onInit() {
    getInsights();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getInsights({bool isLoad = true}) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    isLoading.value = isLoad;

    final token = _loginController.userInfo!.accessToken;
    final result = await _insightsRepository.getInsights(token);

    result.fold((error) {
      isLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isLoading.value = false;
      _insightsData = data;
    });
  }
}