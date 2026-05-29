import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/search/data/models/search_model/search_model_response_model.dart';

import '../datasources/search_remote_datasource.dart';
import 'package:movies_app/feature/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Results>>> searchMovies(String query) async {
    try {
      final results = await remoteDataSource.searchMovies(query);
      return Right(results);
    } catch (e) {
      debugPrint('searchMovies error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
