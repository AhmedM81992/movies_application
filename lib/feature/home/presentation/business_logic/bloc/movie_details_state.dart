import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/load_status.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

@immutable
class MovieDetailsState extends Equatable {
  final LoadStatus detailsStatus;
  final DetailsModel? detailsResult;
  final String detailsError;

  final LoadStatus similarStatus;
  final List<Results> similarResults;
  final String similarError;

  const MovieDetailsState({
    this.detailsStatus = LoadStatus.initial,
    this.detailsResult,
    this.detailsError = '',
    this.similarStatus = LoadStatus.initial,
    this.similarResults = const [],
    this.similarError = '',
  });

  MovieDetailsState copyWith({
    LoadStatus? detailsStatus,
    DetailsModel? detailsResult,
    String? detailsError,
    LoadStatus? similarStatus,
    List<Results>? similarResults,
    String? similarError,
  }) {
    return MovieDetailsState(
      detailsStatus: detailsStatus ?? this.detailsStatus,
      detailsResult: detailsResult ?? this.detailsResult,
      detailsError: detailsError ?? this.detailsError,
      similarStatus: similarStatus ?? this.similarStatus,
      similarResults: similarResults ?? this.similarResults,
      similarError: similarError ?? this.similarError,
    );
  }

  @override
  List<Object?> get props => [
        detailsStatus,
        detailsResult,
        detailsError,
        similarStatus,
        similarResults,
        similarError,
      ];
}
