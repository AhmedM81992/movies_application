import 'package:equatable/equatable.dart';

import '../results_model/results_model_entity.dart';

class UpcomingModelEntity extends Equatable {
  final DatesEntity? dates;
  final int? page;
  final List<ResultsEntity>? results;
  final int? totalPages;
  final int? totalResults;

  const UpcomingModelEntity({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [dates, page, results, totalPages, totalResults];
}

class DatesEntity extends Equatable {
  final String? maximum;
  final String? minimum;

  const DatesEntity({
    this.maximum,
    this.minimum,
  });

  @override
  List<Object?> get props => [maximum, minimum];
}
