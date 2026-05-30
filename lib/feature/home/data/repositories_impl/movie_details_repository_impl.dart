import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';
import '../datasources/movie_details_local_datasource.dart';
import '../datasources/movie_details_remote_datasource.dart';
import 'package:movies_app/feature/home/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;
  final MovieDetailsLocalDataSource localDataSource;

  MovieDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, DetailsModel>> getDetails(int movieId) async {
    try {
      final String? cached =
          await localDataSource.getCachedById(movieId.toString());
      if (cached != null) {
        final detailsModel = DetailsModel.fromJson(jsonDecode(cached));
        return Right(detailsModel);
      }

      final result = await remoteDataSource.getDetails(movieId);
      await localDataSource.cacheById(
          movieId.toString(), jsonEncode(result.toJson()));
      return Right(result);
    } catch (e) {
      debugPrint('getDetails error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getSimilar(int movieId) async {
    try {
      final String? cached =
          await localDataSource.getCachedSimilar(movieId.toString());
      if (cached != null) {
        final list = jsonDecode(cached) as List;
        return Right(list
            .whereType<Map<String, dynamic>>()
            .map(Results.fromJson)
            .toList());
      }

      final result = await remoteDataSource.getSimilar(movieId);
      await localDataSource.cacheSimilar(
        movieId.toString(),
        jsonEncode(result.map((r) => r.toJson()).toList()),
      );
      return Right(result);
    } catch (e) {
      debugPrint('getSimilar error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
