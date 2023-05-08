import 'package:mtgpro/app/modules/login/model/user_login_response_model.dart';

import '../../../data/data_source/local_data_source.dart';
import '../../../data/data_source/remote_data_source.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../model/user_prfile_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLoginResponseModel>> login(Map<String, dynamic> body);
  Future<Either<Failure, UserLoginResponseModel>> userRegister(Map<String, dynamic> body);
  Future<Either<Failure, UserProfileModel>> getOnlyUserData(String token);

  Either<Failure, UserLoginResponseModel> getCashedUserInfo();
  Either<Failure, bool> saveCashedUserInfo(UserLoginResponseModel userLoginResponseModel);
}

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserLoginResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserLoginResponseModel>> userRegister(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.userRegister(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getOnlyUserData(String token) async {
    try {
      final result = await remoteDataSource.getOnlyUserData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, UserLoginResponseModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
  @override
  Either<Failure, bool> saveCashedUserInfo(UserLoginResponseModel userLoginResponseModel) {
    try {
      localDataSource.cacheUserResponse(userLoginResponseModel);
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}