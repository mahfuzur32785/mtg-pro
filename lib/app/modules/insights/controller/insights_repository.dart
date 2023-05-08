import 'package:dartz/dartz.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';
import 'package:mtgpro/app/modules/insights/model/insights_model.dart';

import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import '../../history/model/history_view_model.dart';
import '../../history/model/history_view_response_model.dart';

abstract class InsightsRepository {
  Future<Either<Failure, InsightsModel>> getInsights(String token);
  Future<Either<Failure, HistoryViewResponseModel>> getCardViewHistory(Uri url,String token);
}

class InsightsRepositoryImpl extends InsightsRepository {
  final RemoteDataSource _remoteDataSource;
  InsightsRepositoryImpl(this._remoteDataSource);


  @override
  Future<Either<Failure, InsightsModel>> getInsights(String token) async {
    try {
      final result = await _remoteDataSource.getInsights(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, HistoryViewResponseModel>> getCardViewHistory(Uri url,String token) async {
    try {
      final result = await _remoteDataSource.getCardViewHistory(url,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}