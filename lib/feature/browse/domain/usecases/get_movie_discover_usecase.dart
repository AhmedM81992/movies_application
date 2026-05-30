import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/browse/domain/repositories/browse_repository.dart';
import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';

class GetMovieDiscoverUseCase {
  final BrowseRepository repository;

  GetMovieDiscoverUseCase(this.repository);

  Future<Either<Failure, List<Results>>> call(int genreId) =>
      repository.getMovieDiscover(genreId);
}
