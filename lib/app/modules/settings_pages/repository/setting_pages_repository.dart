import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';
import 'package:mtgpro/app/modules/crm/view_connection/model/veiw_connection_model.dart';
import 'package:mtgpro/app/modules/insights/model/insights_model.dart';
import 'package:mtgpro/app/modules/review/model/review_model.dart';
import 'package:mtgpro/app/modules/settings_pages/account_settings/model/profile_model.dart';
import 'package:mtgpro/app/modules/settings_pages/marketing_material/model/market_model.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/model/billing_info_model.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/model/invoice_model.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/model/plan_model.dart';

import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import '../../crm/model/crm_model.dart';
import '../my_order/model/order_model.dart';

abstract class SettingsPagesRepository {
  Future<Either<Failure, ProfileModel>> getProfileData(String token);
  Future<Either<Failure, String>> postSupportSubmit(Map<String, dynamic> body,String token);
  Future<Either<Failure, String>> postSuggestFeature(Map<String, dynamic> body,String token);
  Future<Either<Failure, Map<String,dynamic>>> postUpdateProfile(Map<String, dynamic> body,String token);
  Future<Either<Failure, String>> postIsNotify(Map<String, dynamic> body,String token);
  Future<Either<Failure, String>> deleteAccount(Map<String, dynamic> body,String token);
  Future<Either<Failure, String>> resetPasswordLink(String token);
  Future<Either<Failure, String>> forgotPasswordLink(String email);
  Future<Either<Failure, List<PricingPlanModel>>> getPricingPlans();
  Future<Either<Failure, List<InvoiceModel>>> getInvoices(String url,String token);
  Future<Either<Failure, PricingPlanModel>> getUserCurrentPlan(String token);
  Future<Either<Failure, BillingInfoModel>> getBillingInfo(String token);
  Future<Either<Failure, String>> postBillingUpdate(Map<String, dynamic> body,String token);
  Future<Either<Failure, String>> cancelPlan(String token);

  Future<Either<Failure, String>> callStripePayment(Map<String, dynamic> body,String token);


  //I AM WORKING FROM HERE
  Future<Either<Failure, List<MyOrderModel>>> getMyOrder(String token);
  Future<Either<Failure, MarketMaterialResponseModel>> getMarketMaterial(Uri url,String token,);
  Future<Either<Failure, CrmListResponseModel>> getCRM(Uri url,String token,);
  Future<Either<Failure, ReviewModel>> getReview(String token);
  Future<Either<Failure, ReviewModel>> postReview(Map<String, dynamic> body,String token);
  Future<Either<Failure, ReviewModel>> updateReview(Map<String, dynamic> body,String token, String id);
  Future<Either<Failure, CrmDetailsModel>> getCRMDetails(String token, int id);
  Future<Either<Failure, String>> updateCrmDetails(Map<String, dynamic> body,String token, int id);
  Future<Either<Failure, String>> downloadFile(String url, String fileName,String format);
  Future<Either<Failure, String>> sendEmail(Map<String, dynamic> body, String token);


}

class SettingsPagesRepositoryImpl extends SettingsPagesRepository {
  final RemoteDataSource _remoteDataSource;
  SettingsPagesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ProfileModel>> getProfileData(String token) async {
    try {
      final result = await _remoteDataSource.getProfileData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> postSupportSubmit(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postSupportSubmit(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> postSuggestFeature(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postSuggestFeature(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, Map<String,dynamic>>> postUpdateProfile(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postUpdateProfile(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> postIsNotify(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postIsNotify(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> deleteAccount(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.deleteAccount(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> resetPasswordLink(String token) async {
    try {
      final result = await _remoteDataSource.resetPasswordLink(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> forgotPasswordLink(String email) async {
    try {
      final result = await _remoteDataSource.forgotPasswordLink(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<InvoiceModel>>> getInvoices(String url,String token) async {
    try {
      final result = await _remoteDataSource.getInvoices(url,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, List<PricingPlanModel>>> getPricingPlans() async {
    try {
      final result = await _remoteDataSource.getPricingPlans();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PricingPlanModel>> getUserCurrentPlan(String token) async {
    try {
      final result = await _remoteDataSource.getUserCurrentPlan(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, BillingInfoModel>> getBillingInfo(String token) async {
    try {
      final result = await _remoteDataSource.getBillingInfo(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> postBillingUpdate(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postBillingUpdate(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> cancelPlan(String token) async {
    try {
      final result = await _remoteDataSource.cancelPlan(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  //........... Payment ..........
  @override
  Future<Either<Failure, String>> callStripePayment(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.callStripePayment(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  //I AM WORKING FROM HERE
  @override
  Future<Either<Failure, List<MyOrderModel>>> getMyOrder(String token) async {
    try {
      final result = await _remoteDataSource.getMyOrderData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, MarketMaterialResponseModel>> getMarketMaterial(Uri url,String token,) async {
    try {
      final result = await _remoteDataSource.getMarketMaterialData(url,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CrmListResponseModel>> getCRM(Uri url,String token,) async {
    try {
      final result = await _remoteDataSource.getCRMData(url,token,);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> getReview(String token) async {
    try {
      final result = await _remoteDataSource.getReviewData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> postReview(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postReviewData(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> updateReview(Map<String, dynamic> body,String token, String id) async {
    try {
      final result = await _remoteDataSource.updateReviewData(body,token,id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CrmDetailsModel>> getCRMDetails(String token, int id) async {
    try {
      final result = await _remoteDataSource.getCRMDetailsData(token,id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> updateCrmDetails(Map<String, dynamic> body,String token, int id) async {
    try {
      final result = await _remoteDataSource.postUpdateCrmDetails(body,token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> downloadFile(String url, String fileName,String format) async {
    final dio = Dio();
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {

        var dioResponse = await dio.get(
          url,
          // onReceiveProgress: (){},
          //Received data with List<int>
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            // receiveTimeout: 0,
          ),
        );

        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = 'sdcard/download/$fileName$format';
        file = File(filePath);
        await file.openSync(mode: FileMode.write);
        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(dioResponse.data);
        await raf.close();
        return Right(filePath);
      }
      else {
        return const Left(ServerFailure('Failed to download', 401));
      }
    }
    catch(e) {
      return Left(ServerFailure(e.toString(), 401));
    }}

  Future<Either<Failure, String>> sendEmail(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.postSendEmail(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  }