import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';
import '../datasources/movie_details_remote_datasource.dart';
import 'package:movies_app/feature/home/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DetailsModel>> getDetails(int movieId) async {
    try {
      final result = await remoteDataSource.getDetails(movieId);
      return Right(result);
    } catch (e) {
      debugPrint('getDetails error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getSimilar(int movieId) async {
    try {
      final result = await remoteDataSource.getSimilar(movieId);
      return Right(result);
    } catch (e) {
      debugPrint('getSimilar error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
