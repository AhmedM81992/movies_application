import 'package:equatable/equatable.dart';

import '../results_model/results_model_entity.dart';

class PopularModelEntity extends Equatable {
  final int? page;
  final List<ResultsEntity>? results;
  final int? totalPages;
  final int? totalResults;

  const PopularModelEntity({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
