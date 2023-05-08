import 'package:dartz/dartz.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';
import 'package:mtgpro/app/data/error/exception.dart';
import 'package:mtgpro/app/data/error/failure.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';

abstract class CardCreateRepository {
  Future<Either<Failure, CardModel>> createCard(Map<String, dynamic> body,String token);
  Future<Either<Failure, Map<String,dynamic>>> cardAddIcon(Map<String, dynamic> body,String token);
  Future<Either<Failure, String>> editCard(Map<String, dynamic> body,int cardId,String token);
  Future<Either<Failure, String>> editSocialIcon(Map<String, dynamic> body,int cardId,String token);
  Future<Either<Failure, String>> deleteIconFromCard(int cardFieldId,String token);
  Future<Either<Failure, String>> updateAdditionalFeature(String url,String status,String token);
  Future<Either<Failure, String>> addUserNmls(String url,String nmlsId,String token);
}

class CardCreateRepositoryImpl extends CardCreateRepository {
  final RemoteDataSource _remoteDataSource;
  CardCreateRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CardModel>> createCard(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.createCard(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> cardAddIcon(Map<String, dynamic> body,String token) async {
    try {
      final result = await _remoteDataSource.cardAddIcon(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> editCard(Map<String, dynamic> body,int cardId,String token) async {
    try {
      final result = await _remoteDataSource.editCard(body,cardId,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> editSocialIcon(Map<String, dynamic> body,int cardId,String token) async {
    try {
      final result = await _remoteDataSource.editSocialIcon(body,cardId,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> deleteIconFromCard(int cardFieldId,String token) async {
    try {
      final result = await _remoteDataSource.deleteIconFromCard(cardFieldId,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> updateAdditionalFeature(String url,String status,String token) async {
    try {
      final result = await _remoteDataSource.updateAdditionalFeature(url,status,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> addUserNmls(String url,String nmlsId,String token) async {
    try {
      final result = await _remoteDataSource.addUserNmls(url,nmlsId,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}