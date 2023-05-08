import 'package:dartz/dartz.dart';
import 'package:mtgpro/app/data/data_source/local_data_source.dart';
import 'package:mtgpro/app/data/data_source/remote_data_source.dart';
import 'package:mtgpro/app/data/error/failure.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/modules/home_cards/model/social_link_model.dart';

import '../../../data/error/exception.dart';

abstract class CardListRepository {
  Future<Either<Failure, List<CardModel>>> getCards(String token,);
  Future<Either<Failure, List<SocialLinkModel>>> getSocialLink();
  Future<Either<Failure, String>> makeLiveCard(String token,int cardId);

  //......... Social Icons
  Either<Failure, List<SocialLinkModel>> getCachedSocialLinks();
  Either<Failure, bool> checkSocialLinks();
  Future<Either<Failure, bool>> cacheSocialLinks();
}

class CardListRepositoryImpl extends CardListRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  CardListRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<CardModel>>> getCards(String token) async {
    try {
      final result = await _remoteDataSource.getCards(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> makeLiveCard(String token,int cardId) async {
    try {
      final result = await _remoteDataSource.makeLiveCard(token,cardId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  //.............. Social Links ................
  @override
  Future<Either<Failure, List<SocialLinkModel>>> getSocialLink() async {
    try {
      final result = await _remoteDataSource.getSocialLink();
      _localDataSource.cacheSocialLinks(result);
      _localDataSource.cacheSocialDate();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  @override
  Future<Either<Failure, bool>> cacheSocialLinks() async {
    try {
      return Right(await _localDataSource.cacheSocialDate());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> checkSocialLinks() {
    try {
      final result = _localDataSource.checkSocialLink();

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, List<SocialLinkModel>> getCachedSocialLinks() {
    try {
      final result = _localDataSource.getSocialLinks();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

}