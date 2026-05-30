import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/load_status.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

@immutable
class HomeScreenState extends Equatable {
  // ---- slice #1: getPopular ----
  final LoadStatus popularStatus;
  final List<Results> popularResults;
  final String? popularError;

  // ---- slice #2: getUpcoming ----
  final LoadStatus upcomingStatus;
  final List<Results> upcomingResults;
  final String? upcomingError;

  // ---- slice #3: getTopRated ----
  final LoadStatus topRatedStatus;
  final List<Results> topRatedResults;
  final String? topRatedError;

  // ---- slice #4: getDetails ----
  final LoadStatus detailsStatus;
  final DetailsModel? detailsResult;
  final String? detailsError;

  const HomeScreenState({
    required this.popularStatus,
    required this.popularResults,
    required this.popularError,
    required this.upcomingStatus,
    required this.upcomingResults,
    required this.upcomingError,
    required this.topRatedStatus,
    required this.topRatedResults,
    required this.topRatedError,
    required this.detailsStatus,
    required this.detailsResult,
    required this.detailsError,
  });

  const HomeScreenState.initial()
      : popularStatus = LoadStatus.initial,
        popularResults = const [],
        popularError = null,
        upcomingStatus = LoadStatus.initial,
        upcomingResults = const [],
        upcomingError = null,
        topRatedStatus = LoadStatus.initial,
        topRatedResults = const [],
        topRatedError = null,
        detailsStatus = LoadStatus.initial,
        detailsResult = null,
        detailsError = null;

  HomeScreenState copyWith({
    LoadStatus? popularStatus,
    List<Results>? popularResults,
    String? popularError,
    LoadStatus? upcomingStatus,
    List<Results>? upcomingResults,
    String? upcomingError,
    LoadStatus? topRatedStatus,
    List<Results>? topRatedResults,
    String? topRatedError,
    LoadStatus? detailsStatus,
    DetailsModel? detailsResult,
    String? detailsError,
  }) {
    return HomeScreenState(
      popularStatus: popularStatus ?? this.popularStatus,
      popularResults: popularResults ?? this.popularResults,
      popularError: popularError,
      upcomingStatus: upcomingStatus ?? this.upcomingStatus,
      upcomingResults: upcomingResults ?? this.upcomingResults,
      upcomingError: upcomingError,
      topRatedStatus: topRatedStatus ?? this.topRatedStatus,
      topRatedResults: topRatedResults ?? this.topRatedResults,
      topRatedError: topRatedError,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      detailsResult: detailsResult ?? this.detailsResult,
      detailsError: detailsError,
    );
  }

  @override
  List<Object?> get props => [
        popularStatus,
        popularResults,
        popularError,
        upcomingStatus,
        upcomingResults,
        upcomingError,
        topRatedStatus,
        topRatedResults,
        topRatedError,
        detailsStatus,
        detailsResult,
        detailsError,
      ];
}
