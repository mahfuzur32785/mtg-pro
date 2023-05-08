import 'package:dartz/dartz.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';

import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';

abstract class CreateStepCardRepository {
  Future<Either<Failure, String>> createStepCard(Map<String, dynamic> body,String token);
}

class CreateStepCardRepositoryImpl extends CreateStepCardRepository {
  final RemoteDataSource remoteDataSource;
  CreateStepCardRepositoryImpl(this.remoteDataSource);


  @override
  Future<Either<Failure, String>> createStepCard(
      Map<String, dynamic> body,String token) async {
    try {
      final result = await remoteDataSource.createStepCard(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}