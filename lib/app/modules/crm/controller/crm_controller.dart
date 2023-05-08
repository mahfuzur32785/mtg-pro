
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtgpro/app/modules/crm/model/crm_model.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../../data/enums/state_status.dart';
import '../../../data/remote_urls.dart';
import '../../login/login_controller.dart';
import '../../settings_pages/repository/setting_pages_repository.dart';

class CrmController extends GetxController {

  CrmController(this._settingsPagesRepository, this._loginController);

  late final SettingsPagesRepository _settingsPagesRepository;
  late final LoginController _loginController;

  var recepientsController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isSelected = false.obs;
  var isLoadMoreLoading = false.obs;
  var isSendMessageBtnLoading = false.obs;

  var formatter = DateFormat("yyyy/MM/dd");
  var searchController = TextEditingController();
  var dateRangeController = "YYYY/MM/DD".obs;

  final scrollController = ScrollController();

  var errorText = ''.obs;
  var crmList = <CrmModel>[].obs;
  CrmListResponseModel? crmListResponseModel;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  @override
  void onInit() {
    _init();
    // dateRangeController.text = "${formatter.format(DateTime.now().subtract(const Duration(days: 30)))} - ${formatter.format(DateTime.now())}";
    getCrmData();
    super.onInit();
  }

  void _init() {
    scrollController.addListener(() {
      final maxExtent = scrollController.position.maxScrollExtent - 100;
      if (maxExtent < scrollController.position.pixels) {
        getCrmDataMore();
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void changeSelect(value){
    isSelected.value = value;
    update();
  }

  void selectAll(value){
    crmList.value = crmList.map((element) => element.copyWith(isSelect: value)).toList();
    update();
  }
  void selectOne(value,id){
    crmList.value = crmList.map((element) => element.id == id ? element.copyWith(isSelect: value) : element.copyWith(isSelect: element.isSelect)).toList();
    update();
  }

  Future<bool> onBackPressed(context) async {
    if (crmList.any((element) => element.isSelect == true)) {
      crmList.value = crmList.map((element) => element.copyWith(isSelect: false)).toList();
      update();
      return false;
    } else if (isSelected.value) {
      changeSelect(false);
      return false;
    } else {
      return true;
    }
  }

  dateChange(int type){
    if (type == 0) {
      dateRangeController.value = "${formatter.format(DateTime.now())} - ${formatter.format(DateTime.now())}";
    }
    if (type == 1) {
      dateRangeController.value = "${formatter.format(DateTime.now().subtract(const Duration(days: 1)))} - ${formatter.format(DateTime.now().subtract(const Duration(days: 1)))}";
    }
    if (type == 2) {
      dateRangeController.value = "${formatter.format(DateTime.now().subtract(const Duration(days: 6)))} - ${formatter.format(DateTime.now())}";
    }
    if (type == 3) {
      dateRangeController.value = "${formatter.format(DateTime.now().subtract(const Duration(days: 29)))} - ${formatter.format(DateTime.now())}";
    }
    if (type == 4) {
      dateRangeController.value = "${formatter.format(DateTime.now().subtract(Duration(days: (DateTime.now().day-1))))} - ${formatter.format(DateTime.now())}";
    }
    if (type == 5) {
      dateRangeController.value = "${"${formatter.format(DateTime.now().subtract(Duration(days: (DateTime.now().day)))).substring(0,8)}01"} - ${formatter.format(DateTime.now().subtract(Duration(days: (DateTime.now().day))))}";
    }
    if (type == 6) {
      chooseDate();
    }
  }

  DateTimeRange dateTimeRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
  chooseDate() async {
    DateTimeRange? newSelectedDate = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(2023),
        lastDate: DateTime(2050),
        initialDateRange: dateTimeRange,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Color(0xFF31A3DD),
                background: Color(0xFF31A3DD),
                surface: Colors.blue,
                onSurface: Colors.white,
                // onSurface: Color(0xFF31A3DD),
              ),
              dialogBackgroundColor: const Color(0xFF31A3DD),
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      dateTimeRange = newSelectedDate;
      dateRangeController.value = "${formatter.format(dateTimeRange.start)} - ${formatter.format(dateTimeRange.end)}";

      // dateRangeController
      //   .. = formatter.format(fromSelectedDate)
      //   ..selection = TextSelection.fromPosition(TextPosition(
      //       offset: dateController.text.length,
      //       affinity: TextAffinity.upstream));
      // fromDate = dateController.text;
      // calendarController.displayDate = fromSelectedDate;
    }
  }

  void getCrmData({search, dateRange}) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    final uri = Uri.parse(RemoteUrls.getCrm).replace(
      queryParameters: {
        'search': searchController.text,
        'paginate': '10',
        'daterange': dateRangeController.value == "YYYY/MM/DD" ? '' : dateRangeController.value,
      },
    );

    final token = _loginController.userInfo!.accessToken;
    _stateStatusRx.value = StateStatus.LOADING;
    final result = await _settingsPagesRepository.getCRM(uri,token,);
    result.fold((error) {
      _stateStatusRx.value = StateStatus.FAILURE;
      errorText.value = error.message;
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      crmListResponseModel = data;
      crmList.value = data.data;
    });
  }

  void getCrmDataMore() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    if (crmListResponseModel == null ||
        crmListResponseModel?.nextPageUrl == null) {
      return;
    }

    Uri url = Uri.parse(crmListResponseModel?.nextPageUrl);

    final token = _loginController.userInfo!.accessToken;
    isLoadMoreLoading.value = true;
    final result = await _settingsPagesRepository.getCRM(url,token);
    result.fold((error) {
      isLoadMoreLoading.value = false;
      errorText.value = error.message;
    }, (data) {
      isLoadMoreLoading.value = false;
      crmListResponseModel = data;
      crmList.addAll(data.data);
    });
  }

  sendMessage({id, recepients, subject, message})async{

    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    final body = <String,dynamic>{};
    body.addAll({"id": id.toString().trim()});
    body.addAll({"subject": subjectController.text.trim()});
    body.addAll({"email": recepientsController.text.trim()});
    body.addAll({"message": messageController.text.trim()});

    print(body.toString());

    final token = _loginController.userInfo!.accessToken;
    isSendMessageBtnLoading.value = true;
    final result = await _settingsPagesRepository.sendEmail(body, token);
    result.fold((error) {
      isSendMessageBtnLoading.value = false;
      Helper.toastMsg(error.message);
    }, (data) {
      isSendMessageBtnLoading.value = false;
      Helper.toastMsg(data);
      Get.back();
    });

  }

}