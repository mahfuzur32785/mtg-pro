import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/modules/splash/model/app_setting_model.dart';

import '../../core/utils/utils.dart';
import '../../modules/home_cards/model/social_link_model.dart';
import '../../modules/login/model/user_login_response_model.dart';
import '../../modules/login/model/user_prfile_model.dart';
import '../error/exception.dart';

abstract class LocalDataSource {
  UserLoginResponseModel getUserResponseModel();
  Future<bool> cacheUserResponse(UserLoginResponseModel userLoginResponseModel);
  Future<bool> cacheUserProfile(UserProfileModel userProfileModel);
  Future<bool> clearUserProfile();
  bool checkOnBoarding();
  Future<bool> cacheOnBoarding();

  Future<bool> cacheWebsiteSetting(AppSettingModel result);
  AppSettingModel getWebsiteSetting();
  //.......... Social Icons ............
  List<SocialLinkModel> getSocialLinks();
  Future<bool> cacheSocialLinks(List<SocialLinkModel> socialLinks);
  bool checkSocialLink();
  Future<bool> cacheSocialDate();
  //.............. language ..............
  // Future<bool> cacheLanguages(List<LanguageModel> languages);
  // bool checkLanguage();
  // Future<bool> cacheLanguage();

  // List<LanguageModel> getCachedLanguages();

}

class LocalDataSourceImpl implements LocalDataSource {
  final _className = 'LocalDataSourceImpl';
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserLoginResponseModel getUserResponseModel() {
    final jsonString =
    sharedPreferences.getString(MySharedPreference.cachedUserResponseKey);
    if (jsonString != null) {
      return UserLoginResponseModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(
      UserLoginResponseModel userLoginResponseModel) {
    return sharedPreferences.setString(
      MySharedPreference.cachedUserResponseKey,
      userLoginResponseModel.toJson(),
    );
  }

  @override
  Future<bool> cacheUserProfile(UserProfileModel userProfileModel) {
    final user = getUserResponseModel();
    user.user != userProfileModel;
    return cacheUserResponse(user);
  }

  @override
  Future<bool> clearUserProfile() {
    return sharedPreferences.remove(MySharedPreference.cachedUserResponseKey);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(MySharedPreference.sOnBoarding);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheOnBoarding() {
    return sharedPreferences.setBool(MySharedPreference.sOnBoarding, true);
  }

  @override
  Future<bool> cacheWebsiteSetting(AppSettingModel settingModel) async {
    // log(settingModel.toJson(), name: _className);
    return sharedPreferences.setString(
        MySharedPreference.cachedWebSettingKey, settingModel.toJson());
  }

  @override
  AppSettingModel getWebsiteSetting() {
    final jsonString =
    sharedPreferences.getString(MySharedPreference.cachedWebSettingKey);
    // log(jsonString.toString(), name: _className);
    if (jsonString != null) {
      return AppSettingModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }


  //.......... Social Icons ............
  @override
  List<SocialLinkModel> getSocialLinks() {
    final jsonString = sharedPreferences.getString(MySharedPreference.cacheSocialLinksKey);
    if (jsonString != null) {
      var mapData = json.decode(jsonString.toString());
      return List<dynamic>.from(mapData["data"]).map((e) => SocialLinkModel.fromJson(e)).toList();
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheSocialLinks(List<SocialLinkModel> socialLinks) {
    var data = {};
    data["data"] = socialLinks;
    return sharedPreferences.setString(MySharedPreference.cacheSocialLinksKey, json.encode(data));
  }

  @override
  bool checkSocialLink() {
    final jsonString = sharedPreferences.getString(MySharedPreference.isCachedSocialLinks);
    if (jsonString != null) {
      int days = Utils.calculateMaxDays(jsonString, DateTime.now().toString());
      print("........ Days $days .............");
      return days > 3 ? false : true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheSocialDate() {
    return sharedPreferences.setString(MySharedPreference.isCachedSocialLinks, DateTime.now().toString());
  }

}
