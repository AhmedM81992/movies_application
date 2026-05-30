import 'package:equatable/equatable.dart';

class SearchModelEntity extends Equatable {
  final int? page;
  final List<ResultsEntity>? results;
  final int? totalPages;
  final int? totalResults;

  const SearchModelEntity({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}

class ResultsEntity extends Equatable {
  final String? fireBaseId;
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const ResultsEntity({
    this.fireBaseId,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
        fireBaseId,
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
