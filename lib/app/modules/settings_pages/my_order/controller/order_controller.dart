import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/model/order_model.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/enums/state_status.dart';
import '../../../login/login_controller.dart';
import '../../repository/setting_pages_repository.dart';

class OrderController extends GetxController {

  OrderController(this._settingsPagesRepository, this._loginController);

  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var errorText = ''.obs;
  var myOrder = <MyOrderModel>[].obs;

  @override
  void onInit() {
    getMyOrderData();
    super.onInit();
  }

  void getMyOrderData() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _settingsPagesRepository.getMyOrder(token);
    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      errorText.value = error.message;
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      myOrder.value = data;
    });
  }
}