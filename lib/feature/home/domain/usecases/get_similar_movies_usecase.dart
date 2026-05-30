import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/home/domain/repositories/movie_details_repository.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

class GetSimilarMoviesUseCase {
  final MovieDetailsRepository repository;

  GetSimilarMoviesUseCase(this.repository);

  Future<Either<Failure, List<Results>>> call(int movieId) =>
      repository.getSimilar(movieId);
}
