import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Results>>> getPopular();
  Future<Either<Failure, List<Results>>> getUpcoming();
  Future<Either<Failure, List<Results>>> getTopRated();
  Future<Either<Failure, DetailsModel>> getDetails(int movieId);
}
