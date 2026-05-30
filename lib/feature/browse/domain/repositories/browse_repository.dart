import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';
import 'package:movies_app/feature/browse/data/models/movies_list_model/movies_list_model_response_model.dart';

abstract class BrowseRepository {
  Future<Either<Failure, List<Genres>>> getMoviesList();
  Future<Either<Failure, List<Results>>> getMovieDiscover(int genreId);
}
