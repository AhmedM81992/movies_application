import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';
import 'package:movies_app/feature/browse/data/models/movies_list_model/movies_list_model_response_model.dart';

import '../datasources/browse_remote_datasource.dart';
import 'package:movies_app/feature/browse/domain/repositories/browse_repository.dart';

class BrowseRepositoryImpl implements BrowseRepository {
  final BrowseRemoteDataSource remoteDataSource;

  BrowseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Genres>>> getMoviesList() async {
    try {
      final results = await remoteDataSource.getMoviesList();
      return Right(results);
    } catch (e) {
      debugPrint('getMoviesList error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getMovieDiscover(int genreId) async {
    try {
      final results = await remoteDataSource.getMovieDiscover(genreId);
      return Right(results);
    } catch (e) {
      debugPrint('getMovieDiscover error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
