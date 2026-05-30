import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';
import 'package:movies_app/feature/bookmarks/data/models/bookmark_movie/bookmark_movie_response_model.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';
import '../datasources/bookmark_remote_datasource.dart';
import 'package:movies_app/feature/bookmarks/domain/repositories/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkRemoteDataSource remoteDataSource;

  BookmarkRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<BookmarkMovieEntity>>> getFavorites() {
    return remoteDataSource.getFavorites().map(
          (models) => Right<Failure, List<BookmarkMovieEntity>>(models),
        );
  }

  @override
  Future<Either<Failure, void>> addFavorite(BookmarkMovieEntity movie) async {
    try {
      final model = BookmarkMovieResponseModel(
        id: movie.id,
        title: movie.title,
        backdropPath: movie.backdropPath,
        posterPath: movie.posterPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        fireBaseId: movie.fireBaseId,
      );
      await remoteDataSource.addFavorite(model);
      return const Right(null);
    } catch (e) {
      debugPrint('addFavorite error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavorite(String firebaseId) async {
    try {
      await remoteDataSource.deleteFavorite(firebaseId);
      return const Right(null);
    } catch (e) {
      debugPrint('deleteFavorite error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
