import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/browse/domain/repositories/browse_repository.dart';
import 'package:movies_app/feature/browse/data/models/movies_list_model/movies_list_model_response_model.dart';

class GetGenresUseCase {
  final BrowseRepository repository;

  GetGenresUseCase(this.repository);

  Future<Either<Failure, List<Genres>>> call() => repository.getMoviesList();
}
