import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/modules/card_view/model/card_preview_model.dart';
import 'package:mtgpro/app/modules/crm/model/crm_model.dart';
import 'package:mtgpro/app/modules/crm/view_connection/model/veiw_connection_model.dart';
import 'package:mtgpro/app/modules/history/model/history_view_model.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/modules/insights/model/insights_model.dart';
import 'package:mtgpro/app/modules/login/model/user_login_response_model.dart';
import 'package:mtgpro/app/modules/review/model/review_model.dart';
import 'package:mtgpro/app/modules/settings_pages/account_settings/model/profile_model.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/model/order_model.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/model/billing_info_model.dart';
import 'package:mtgpro/app/modules/splash/model/app_setting_model.dart';

import '../../modules/history/model/history_view_response_model.dart';
import '../../modules/home_cards/model/social_link_model.dart';
import '../../modules/login/model/user_prfile_model.dart';
import '../../modules/settings_pages/marketing_material/model/market_model.dart';
import '../../modules/settings_pages/my_subscription/model/invoice_model.dart';
import '../../modules/settings_pages/pricing/model/plan_model.dart';
import '../error/exception.dart';
import '../remote_urls.dart';
abstract class RemoteDataSource {
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body);
  Future<UserLoginResponseModel> userRegister(Map<String, dynamic> body);
  Future<UserProfileModel> getOnlyUserData(String token);
  Future<String> createStepCard(Map<String, dynamic> body,String token);

  Future<CardModel> createCard(Map<String, dynamic> body,String token);
  Future<Map<String,dynamic>> cardAddIcon(Map<String, dynamic> body,String token);
  Future<String> editCard(Map<String, dynamic> body,int cardId,String token);
  Future<String> editSocialIcon(Map<String, dynamic> body,int cardId,String token);
  Future<String> deleteIconFromCard(int cardFieldId,String token);
  Future<String> updateAdditionalFeature(String url,String status,String token);
  Future<String> addUserNmls(String url,String nmlsId,String token);

  Future<List<CardModel>> getCards(String token);
  Future<CardPreviewModel> getCardView(String url, String token);
  Future<String> connectWithMe(Map<String, dynamic> body,String token);
  Future<String> postCreditAuthorization(Map<String, dynamic> body,String token);
  Future<String> postQuickApplication(Map<String, dynamic> body,String token);
  Future<String> makeLiveCard(String token,int cardId);
  Future<List<SocialLinkModel>> getSocialLink();

  Future<InsightsModel> getInsights(String token);
  Future<HistoryViewResponseModel> getCardViewHistory(Uri url,String token);

  Future<ProfileModel> getProfileData(String token);
  Future<String> postSupportSubmit(Map<String, dynamic> body,String token);
  Future<String> postSuggestFeature(Map<String, dynamic> body,String token);
  Future<Map<String,dynamic>> postUpdateProfile(Map<String, dynamic> body,String token);
  Future<String> postIsNotify(Map<String, dynamic> body,String token);
  Future<String> deleteAccount(Map<String, dynamic> body,String token);
  Future<String> resetPasswordLink(String token);
  Future<String> forgotPasswordLink(String email);
  Future<List<PricingPlanModel>> getPricingPlans();
  Future<List<InvoiceModel>> getInvoices(String url,String token);
  Future<PricingPlanModel> getUserCurrentPlan(String token);
  Future<BillingInfoModel> getBillingInfo(String token);
  Future<String> postBillingUpdate(Map<String, dynamic> body,String token);
  Future<String> cancelPlan(String token);
  //....... Payment .........
  Future<String> callStripePayment(Map<String, dynamic> body,String token);

  Future<AppSettingModel> websiteSetup();


  //I AM WORKING FROM HERE

  Future<List<MyOrderModel>> getMyOrderData(String token);
  Future<MarketMaterialResponseModel> getMarketMaterialData(Uri url,String token,);
  Future<CrmListResponseModel> getCRMData(Uri url,String token,);
  Future<String> saveVCardToCrm(Map<String, dynamic> body,String token);
  Future<ReviewModel> getReviewData(String token);
  Future<ReviewModel> postReviewData(Map<String, dynamic> body,String token);
  Future<ReviewModel> updateReviewData(Map<String, dynamic> body,String token, String id);
  Future<CrmDetailsModel> getCRMDetailsData(String token,int id);
  Future<String> postUpdateCrmDetails(Map<String, dynamic> body,String token, int id);
  Future<String> postSendEmail(Map<String, dynamic> body,String token);


}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;
  final _className = 'RemoteDataSourceImpl';
  RemoteDataSourceImpl({required this.client});

  Future<dynamic> callClientWithCatchException(
      CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      if (kDebugMode) {
        print("status code : ${response.statusCode}");
        print(response.body);
      }
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException('Please check your \nInternet Connection', 10061);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }


  @override
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      Get.snackbar('Message', responseJsonBody["message"]);
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<UserLoginResponseModel> userRegister(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userRegister);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      Get.snackbar('Message', responseJsonBody["message"]);
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<UserProfileModel> getOnlyUserData(String token) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getOnlyUserData);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return UserProfileModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<String> createStepCard(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.createStepCard);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      Get.snackbar('Message', responseJsonBody["message"]);
      return responseJsonBody["message"];
    }
  }

  @override
  Future<CardModel> createCard(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.createCard);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return CardModel.fromMap(responseJsonBody['data']);
    }
  }

  @override
  Future<Map<String,dynamic>> cardAddIcon(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.cardAddIcon);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody;
    }
  }

  @override
  Future<String> editCard(Map<String, dynamic> body,int cardId,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.editCard(cardId));

    final clientMethod = client.put(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> editSocialIcon(Map<String, dynamic> body,int cardId,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.editSocialIcon(cardId));

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<String> deleteIconFromCard(int cardFieldId,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.deleteIconFromCard(cardFieldId));

    final clientMethod = client.delete(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> updateAdditionalFeature(String url,String status,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(url);

    final clientMethod = client.post(uri, headers: headers,body: {"status": status});
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> addUserNmls(String url,String nmlsId,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(url);

    final clientMethod = client.post(uri, headers: headers,body: {"nmls_id": nmlsId});
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<InsightsModel> getInsights(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getInsights);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return InsightsModel.fromMap(responseJsonBody["data"]);
    }
  }
  @override
  Future<HistoryViewResponseModel> getCardViewHistory(Uri url,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    // final uri = Uri.parse(RemoteUrls.getInsights);

    final clientMethod = client.get(url, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw DataNotFoundException(errorMsg, 401);
    } {
      return HistoryViewResponseModel.fromMap(responseJsonBody["data"]);
    }
  }
  @override
  Future<List<CardModel>> getCards(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getMyCards);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List<dynamic>.from(responseJsonBody['data']).map((e) => CardModel.fromMap(e)).toList();
    }
  }

  @override
  Future<CardPreviewModel> getCardView(String url, String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(url);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return CardPreviewModel.fromMap(responseJsonBody["data"]);
    }
  }


  @override
  Future<String> connectWithMe(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postConnectWithMe);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }


  @override
  Future<String> postCreditAuthorization(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postCreditAuthorization);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }


  @override
  Future<String> postQuickApplication(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postQuickApplication);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> makeLiveCard(String token,int cardId) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.makeCardLive);

    final clientMethod = client.post(uri, headers: headers, body: {'id': '$cardId'},);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<List<SocialLinkModel>> getSocialLink() async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.getSocialLink);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List<dynamic>.from(responseJsonBody['data']).map((e) => SocialLinkModel.fromMap(e)).toList();
    }
  }

  ///.............. Settings Pages Api ............
  @override
  Future<ProfileModel> getProfileData(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getProfile);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return ProfileModel.fromMap(responseJsonBody["data"]);
    }
  }

  @override
  Future<String> postSupportSubmit(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postSupport);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<String> postSuggestFeature(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postSuggestFeature);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<Map<String,dynamic>> postUpdateProfile(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postUpdateProfile);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody;
    }
  }
  @override
  Future<String> postIsNotify(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postIsNotify);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<String> deleteAccount(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.deleteAccount);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<String> resetPasswordLink(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.resetPasswordLink);

    final clientMethod = client.post(uri, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<String> forgotPasswordLink(String email) async {
    final uri = Uri.parse(RemoteUrls.forgotPasswordLink);
    final headers = {'Accept': 'application/json'};
    final clientMethod = client.post(uri,body: {"email": email},headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }
  @override
  Future<List<PricingPlanModel>> getPricingPlans() async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.getPricingPlan);
    // final uri = Uri.parse('http://192.168.203.60:8000/api/get-plan');

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List<dynamic>.from(responseJsonBody['data']).map((e) => PricingPlanModel.fromMap(e)).toList();
    }
  }
  @override
  Future<List<InvoiceModel>> getInvoices(String url,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(url);
    // final uri = Uri.parse('http://192.168.203.60:8000/api/get-plan');

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List<dynamic>.from(responseJsonBody['data']["data"]).map((e) => InvoiceModel.fromMap(e)).toList();
    }
  }
  @override
  Future<PricingPlanModel> getUserCurrentPlan(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getUserCurrentPlan);
    // final uri = Uri.parse('http://192.168.203.60:8000/api/user-plan');

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return PricingPlanModel.fromMap(responseJsonBody["data"]);
    }
  }
  @override
  Future<BillingInfoModel> getBillingInfo(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getBillingInfo);
    // final uri = Uri.parse('http://192.168.203.60:8000/api/user-plan');

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return BillingInfoModel.fromMap(responseJsonBody);
    }
  }

  @override
  Future<String> postBillingUpdate(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postBillingUpdate);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> cancelPlan(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.cancelPlan);
    // final uri = Uri.parse('http://192.168.203.60:8000/api/user-plan');

    final clientMethod = client.post(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  ///........... Payment ..............

  @override
  Future<String> callStripePayment(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.payWithStripe);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  ///.............. App Settings Related Methods ...............
  @override
  Future<AppSettingModel> websiteSetup() async {
    // final uri = Uri.parse(RemoteUrls.websiteSetup);
    final uri = Uri.parse(RemoteUrls.websiteSetup);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    return AppSettingModel.fromMap(responseJsonBody['data']);
  }




  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

      ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

      /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');

      case 422:

      ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

      ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occurred while communication with Server',
            response.statusCode);
    }
  }
  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }
  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }


  // I AM WORKING FROM HERE

  @override
  Future<List<MyOrderModel>> getMyOrderData(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getMyOrder);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return List<dynamic>.from(responseJsonBody['data']).map((e) => MyOrderModel.fromJson(e)).toList();
    }
  }

  @override
  Future<MarketMaterialResponseModel> getMarketMaterialData(Uri url,String token,) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};

    final clientMethod = client.get(url, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return MarketMaterialResponseModel.fromJson(responseJsonBody["data"]);
    }
  }

  @override
  Future<CrmListResponseModel> getCRMData(Uri url,String token,) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};

    final clientMethod = client.get(url, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return CrmListResponseModel.fromJson(responseJsonBody["data"]);
    }
  }


  @override
  Future<String> saveVCardToCrm(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.saveVCardToCrm);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      // Helper.toastMsg(responseJsonBody["message"]);
      return responseJsonBody["message"];
    }
  }

  @override
  Future<ReviewModel> getReviewData(String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getReview);

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      const errorMsg = "No Data Found!";
      // Helper.toastMsg(errorMsg);
      throw const DataNotFoundException(errorMsg, 210);
    } {
      return ReviewModel.fromJson(responseJsonBody["data"]);
    }
  }

  @override
  Future<ReviewModel> postReviewData(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postReview);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      Helper.toastMsg(responseJsonBody["message"]);
      return ReviewModel.fromJson(responseJsonBody["data"]);
    }
  }

  @override
  Future<ReviewModel> updateReviewData(Map<String, dynamic> body,String token, String id) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.updateReview(id));

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      Helper.toastMsg(errorMsg);
      throw UnauthorisedException(errorMsg, 401);
    } {
      Helper.toastMsg(responseJsonBody["message"]);
      return ReviewModel.fromJson(responseJsonBody["data"]);
    }
  }

  @override
  Future<CrmDetailsModel> getCRMDetailsData(String token, int id) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.getCrmDetails(id));

    final clientMethod = client.get(uri, headers: headers,);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return CrmDetailsModel.fromJson(responseJsonBody["data"]);
    }
  }

  @override
  Future<String> postUpdateCrmDetails(Map<String, dynamic> body,String token, int id) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postUpdateCrmDetails(id));

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

  @override
  Future<String> postSendEmail(Map<String, dynamic> body,String token) async {
    final headers = {'Accept': 'application/json','Authorization': 'Bearer $token'};
    final uri = Uri.parse(RemoteUrls.postSendEmail);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } {
      return responseJsonBody["message"];
    }
  }

}