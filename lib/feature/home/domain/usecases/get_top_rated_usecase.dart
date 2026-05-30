import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/feature/home/domain/repositories/home_repository.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

class GetTopRatedUseCase {
  final HomeRepository repository;

  GetTopRatedUseCase(this.repository);

  Future<Either<Failure, List<Results>>> call() => repository.getTopRated();
}
