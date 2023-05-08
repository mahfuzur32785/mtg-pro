import 'package:dartz/dartz.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';

import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';

abstract class VCardToCrmRepository {
  Future<Either<Failure, String>> saveToCrm(Map<String, dynamic> body,String token);
}

class VCardToCrmRepositoryImpl extends VCardToCrmRepository {
  final RemoteDataSource remoteDataSource;
  VCardToCrmRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> saveToCrm(Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.saveVCardToCrm(body,token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}