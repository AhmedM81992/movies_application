import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/popular_model/popular_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/top_rated_model/top_rated_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/upcoming_model/upcoming_model_response_model.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import 'package:movies_app/feature/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Results>>> getPopular() async {
    try {
      final String? cached = await localDataSource.getCachedPopular();
      if (cached != null) {
        final popularModel = PopularModel.fromJson(jsonDecode(cached));
        return Right(popularModel.results ?? []);
      }

      final results = await remoteDataSource.getPopular();
      // Cache the full response: re-fetch the raw model JSON for caching
      final popularModel = PopularModel(
        results: results,
        page: null,
        totalPages: null,
        totalResults: null,
      );
      await localDataSource.cachePopular(jsonEncode(popularModel.toJson()));
      return Right(results);
    } catch (e) {
      debugPrint('getPopular error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getUpcoming() async {
    try {
      final String? cached = await localDataSource.getCachedUpcoming();
      if (cached != null) {
        final upcomingModel = UpcomingModel.fromJson(jsonDecode(cached));
        return Right(upcomingModel.results ?? []);
      }

      final results = await remoteDataSource.getUpcoming();
      final upcomingModel = UpcomingModel(
        results: results,
        page: null,
        totalPages: null,
        totalResults: null,
        dates: null,
      );
      await localDataSource.cacheUpcoming(jsonEncode(upcomingModel.toJson()));
      return Right(results);
    } catch (e) {
      debugPrint('getUpcoming error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getTopRated() async {
    try {
      final String? cached = await localDataSource.getCachedTopRated();
      if (cached != null) {
        final topRatedModel = TopRatedModel.fromJson(jsonDecode(cached));
        return Right(topRatedModel.results ?? []);
      }

      final results = await remoteDataSource.getTopRated();
      final topRatedModel = TopRatedModel(
        results: results,
        page: null,
        totalPages: null,
        totalResults: null,
      );
      await localDataSource.cacheTopRated(jsonEncode(topRatedModel.toJson()));
      return Right(results);
    } catch (e) {
      debugPrint('getTopRated error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsModel>> getDetails(int movieId) async {
    try {
      final String? cached =
          await localDataSource.getCachedDetails(movieId.toString());
      if (cached != null) {
        return Right(DetailsModel.fromJson(jsonDecode(cached)));
      }

      final result = await remoteDataSource.getDetails(movieId);
      await localDataSource.cacheDetails(
          movieId.toString(), jsonEncode(result.toJson()));
      return Right(result);
    } catch (e) {
      debugPrint('getDetails error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
