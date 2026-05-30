import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';

abstract class BookmarkRepository {
  Stream<Either<Failure, List<BookmarkMovieEntity>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(BookmarkMovieEntity movie);
  Future<Either<Failure, void>> deleteFavorite(String firebaseId);
}
