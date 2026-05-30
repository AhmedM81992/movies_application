import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/search/domain/repositories/search_repository.dart';
import 'package:movies_app/feature/search/data/models/search_model/search_model_response_model.dart';

class SearchMoviesUseCase {
  final SearchRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<Either<Failure, List<Results>>> call(String query) =>
      repository.searchMovies(query);
}
