import 'package:get/get.dart';

import '../../../../data/enums/state_status.dart';

class MyCalculatorController extends GetxController {
  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    _stateStatusRx.value = StateStatus.LOADING;
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _stateStatusRx.value = StateStatus.SUCCESS;
    });
  }
}