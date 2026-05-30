import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';
import 'package:movies_app/feature/browse/data/models/movies_list_model/movies_list_model_response_model.dart';

@immutable
class BrowseState extends Equatable {
  final LoadStatus genresStatus;
  final List<Genres> genres;
  final String? genresError;

  final LoadStatus discoverStatus;
  final List<Results> discoverResults;
  final String? discoverError;

  const BrowseState({
    this.genresStatus = LoadStatus.initial,
    this.genres = const [],
    this.genresError,
    this.discoverStatus = LoadStatus.initial,
    this.discoverResults = const [],
    this.discoverError,
  });

  BrowseState copyWith({
    LoadStatus? genresStatus,
    List<Genres>? genres,
    Object? genresError = _sentinel,
    LoadStatus? discoverStatus,
    List<Results>? discoverResults,
    Object? discoverError = _sentinel,
  }) {
    return BrowseState(
      genresStatus: genresStatus ?? this.genresStatus,
      genres: genres ?? this.genres,
      genresError:
          genresError is String ? genresError as String? : this.genresError,
      discoverStatus: discoverStatus ?? this.discoverStatus,
      discoverResults: discoverResults ?? this.discoverResults,
      discoverError: discoverError is String
          ? discoverError as String?
          : this.discoverError,
    );
  }

  @override
  List<Object?> get props => [
        genresStatus,
        genres,
        genresError,
        discoverStatus,
        discoverResults,
        discoverError,
      ];
}

const Object _sentinel = Object();
