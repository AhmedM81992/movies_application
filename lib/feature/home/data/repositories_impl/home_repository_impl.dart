import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';
import '../datasources/home_remote_datasource.dart';
import 'package:movies_app/feature/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Results>>> getPopular() async {
    try {
      final results = await remoteDataSource.getPopular();
      return Right(results);
    } catch (e) {
      debugPrint('getPopular error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getUpcoming() async {
    try {
      final results = await remoteDataSource.getUpcoming();
      return Right(results);
    } catch (e) {
      debugPrint('getUpcoming error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Results>>> getTopRated() async {
    try {
      final results = await remoteDataSource.getTopRated();
      return Right(results);
    } catch (e) {
      debugPrint('getTopRated error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

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
}
