import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mtgpro/app/modules/crm/controller/crm_controller.dart';
import 'package:mtgpro/app/modules/home/home_controller.dart';
import 'package:mtgpro/app/modules/no_internet/controller/no_internet_controller.dart';
import 'package:mtgpro/app/modules/review/review_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mtgpro/app/modules/login/controller/auth_repository.dart';
import 'package:mtgpro/app/modules/scanner/controller/scanner_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/repository/setting_pages_repository.dart';

import '../../main.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../modules/login/login_controller.dart';
import '../modules/splash/controller/splash_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<Client>(() => Client());
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl(client: Get.find()));
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl(sharedPreferences: Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => LoginController(Get.find()));
    Get.lazyPut(() => SplashController(Get.find()));
    Get.lazyPut(() => NoInternetController(Get.find()));
    Get.lazyPut<SettingsPagesRepository>(() => SettingsPagesRepositoryImpl(Get.find()));
    Get.lazyPut(() => ScannerController(Get.find()));
  }

}