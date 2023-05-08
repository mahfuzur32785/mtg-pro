import 'package:dartz/dartz.dart';
import 'package:mtgpro/app/modules/splash/model/app_setting_model.dart';
import '../../../data/data_source/local_data_source.dart';
import '../../../data/data_source/remote_data_source.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';

abstract class AppSettingRepository {
  Future<Either<Failure, AppSettingModel>> websiteSetup();
  Either<Failure, AppSettingModel> getCachedWebsiteSetup();

  Either<Failure, bool> checkOnBoarding();
  Future<Either<Failure, bool>> cacheOnBoarding();
}

class AppSettingRepositoryImp extends AppSettingRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AppSettingRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      final result = localDataSource.checkOnBoarding();

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> cacheOnBoarding() async {
    try {
      return Right(await localDataSource.cacheOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AppSettingModel>> websiteSetup() async {
    try {
      final result = await remoteDataSource.websiteSetup();
      localDataSource.cacheWebsiteSetting(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, AppSettingModel> getCachedWebsiteSetup() {
    try {
      final result = localDataSource.getWebsiteSetting();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
