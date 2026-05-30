import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/search/data/models/search_model/search_model_response_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Results>>> searchMovies(String query);
}
