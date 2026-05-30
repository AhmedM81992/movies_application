import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';
import 'package:movies_app/feature/bookmarks/domain/repositories/bookmark_repository.dart';

class GetFavoritesUseCase {
  final BookmarkRepository repository;

  GetFavoritesUseCase(this.repository);

  Stream<Either<Failure, List<BookmarkMovieEntity>>> call() =>
      repository.getFavorites();
}
