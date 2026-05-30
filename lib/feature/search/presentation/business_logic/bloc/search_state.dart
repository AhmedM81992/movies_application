import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/search/data/models/search_model/search_model_response_model.dart';

@immutable
class SearchState extends Equatable {
  final LoadStatus status;
  final List<Results> results;
  final String? error;
  final String query;

  const SearchState({
    this.status = LoadStatus.initial,
    this.results = const [],
    this.error,
    this.query = '',
  });

  SearchState copyWith({
    LoadStatus? status,
    List<Results>? results,
    Object? error = _sentinel,
    String? query,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      error: error is String ? error as String? : this.error,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [status, results, error, query];
}

/// Sentinel value to distinguish between "not provided" and explicit null.
const Object _sentinel = Object();
