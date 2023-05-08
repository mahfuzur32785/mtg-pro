import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/modules/crm/view_connection/model/veiw_connection_model.dart';

import '../../../../data/enums/state_status.dart';
import '../../../login/login_controller.dart';
import '../../../settings_pages/repository/setting_pages_repository.dart';

class ViewConnectionController extends GetxController {
  ViewConnectionController(this._settingsPagesRepository, this._loginController);

  late final SettingsPagesRepository _settingsPagesRepository;
  late final LoginController _loginController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var isLoading = false.obs;
  var errorText = ''.obs;
  CrmDetailsModel? crmDetailsModel;

  dynamic argumentData = Get.arguments;

  @override
  void onInit() {

    print("userId ${argumentData[0]}");
    print("userName ${argumentData[1]}");
    getCrmDetails(argumentData[0]);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getCrmDetails(id) async {
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
      crmDetailsModel = data;
    });
  }
}