import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/home/domain/repositories/home_repository.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';

class GetDetailsUseCase {
  final HomeRepository repository;

  GetDetailsUseCase(this.repository);

  Future<Either<Failure, DetailsModel>> call(int movieId) =>
      repository.getDetails(movieId);
}
