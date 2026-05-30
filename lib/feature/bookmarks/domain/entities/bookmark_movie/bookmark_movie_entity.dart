import 'package:equatable/equatable.dart';

class BookmarkMovieEntity extends Equatable {
  final int? id;
  final String? title;
  final String? backdropPath;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage;
  final String? fireBaseId;

  const BookmarkMovieEntity({
    this.id,
    this.title,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.fireBaseId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        backdropPath,
        posterPath,
        releaseDate,
        voteAverage,
        fireBaseId,
      ];
}
