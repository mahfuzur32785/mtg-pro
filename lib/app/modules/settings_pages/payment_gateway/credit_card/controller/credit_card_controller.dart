import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../../../core/services/notification_service.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../../data/enums/state_status.dart';
import '../../../../../data/remote_urls.dart';

class CreditCardController extends GetxController {
  final SettingsPagesRepository _settingsPagesRepository;
  final LoginController _loginController;

  CreditCardController(this._settingsPagesRepository,this._loginController);

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var body = <String, dynamic>{};

  @override
  void onInit() {
    var arguments = Get.arguments;
    body = arguments;
    super.onInit();
  }

  @override
  // TODO: implement isClosed
  bool get isClosed => super.isClosed;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final formKey = GlobalKey<FormState>();


  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    if (creditCardModel == null) return;
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    update();
  }

  void callStripePayment() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    body.addAll({"card_number": cardNumber.trim()});
    body.addAll({"cvc": cvvCode.trim()});
    body.addAll({"date": expiryDate.trim()});

    _stateStatusRx.value = StateStatus.LOADING;
    final token = _loginController.userInfo!.accessToken;

    final result = await _settingsPagesRepository.callStripePayment(body,token);

    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      Helper.toastMsg(error.message);
    }, (data) async {
      Helper.toastMsg(data);
      _stateStatusRx.value = StateStatus.SUCCESS;
      await NotificationService.sendNotification([], "Thank you for order",
          "Thank you for purchasing from MTGPRO.ME. Plan Name ${body["plan_name"]}, Total order \$${body["cost"]}");
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Navigator.of(Get.context!).pop();
        Get.offAndToNamed(Routes.subscription);
      });
    });
  }

}