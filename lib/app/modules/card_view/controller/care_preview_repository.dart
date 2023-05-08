import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';
import 'package:mtgpro/app/modules/card_view/model/card_preview_model.dart';

import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';

abstract class CardPreviewRepository {
  Future<Either<Failure, CardPreviewModel>> getCard(String url,String token,);
  Future<Either<Failure, String>> downloadFile(String url, String fileName,);
  Future<Either<Failure, String>> downloadContacts(String url, String fileName,);
  Future<Either<Failure, String>> connectWithMe(Map<String, dynamic> body, String token,);
  Future<Either<Failure, String>> postCreditAuthorization(Map<String, dynamic> body, String token,);
  Future<Either<Failure, String>> postQuickApplication(Map<String, dynamic> body, String token,);
  Future<bool> isExist(String filename,{int isInSdCard = 0});
}

class CardPreviewRepositoryImpl extends CardPreviewRepository {
  final RemoteDataSource _remoteDataSource;
  CardPreviewRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CardPreviewModel>> getCard(String url, String token) async {
    try {
      final result = await _remoteDataSource.getCardView(url,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> connectWithMe(Map<String, dynamic> body, String token,) async {
    try {
      final result = await _remoteDataSource.connectWithMe(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> postCreditAuthorization(Map<String, dynamic> body, String token,) async {
    try {
      final result = await _remoteDataSource.postCreditAuthorization(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> postQuickApplication(Map<String, dynamic> body, String token,) async {
    try {
      final result = await _remoteDataSource.postQuickApplication(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> downloadFile(String url, String fileName,) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        if (Platform.isAndroid) {
          filePath = 'sdcard/download/$fileName.jpg';
        } else {
          print("xxxxxxxxxxx");
          var directory = await getDownloadsDirectory();
          filePath = "${directory?.path}${Platform.pathSeparator}$fileName.jpg";
        }
        file = File(filePath);
        await file.writeAsBytes(bytes);
        return Right(filePath);
      }
      else {
        return const Left(ServerFailure('Failed to download', 401));
      }
    }
    catch(e){
      return Left(ServerFailure(e.toString(), 401));
    }
  }

  @override
  Future<Either<Failure, String>> downloadContacts(String url, String fileName,) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = 'sdcard/download/contacts$fileName.vcf';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        return Right(filePath);
      }
      else {
        return const Left(ServerFailure('Failed to download', 401));
      }
    }
    catch(e){
      return Left(ServerFailure(e.toString(), 401));
    }
  }

  @override
  Future<bool> isExist(String filename,{int isInSdCard = 0}) async {
    String dir = '';
    if (isInSdCard == 1) {
      dir = 'sdcard/download';
    } else {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
    File file = File('$dir/$filename');
    var isExist = await File(file.path).exists();
    return isExist;
  }
}