import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';
import 'package:movies_app/feature/bookmarks/domain/repositories/bookmark_repository.dart';

class AddFavoriteUseCase {
  final BookmarkRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(BookmarkMovieEntity movie) =>
      repository.addFavorite(movie);
}
