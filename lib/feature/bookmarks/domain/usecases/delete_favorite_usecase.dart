import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/bookmarks/domain/repositories/bookmark_repository.dart';

class DeleteFavoriteUseCase {
  final BookmarkRepository repository;

  DeleteFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(String firebaseId) =>
      repository.deleteFavorite(firebaseId);
}
