import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';

class BookmarkMovieResponseModel extends BookmarkMovieEntity {
  const BookmarkMovieResponseModel({
    super.id,
    super.title,
    super.backdropPath,
    super.posterPath,
    super.releaseDate,
    super.voteAverage,
    super.fireBaseId,
  });

  factory BookmarkMovieResponseModel.fromJson(Map<String, dynamic> json,
      {String? fireBaseId}) {
    return BookmarkMovieResponseModel(
      id: json['id'],
      title: json['title'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      fireBaseId: fireBaseId ?? json['fireBaseId'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['backdrop_path'] = backdropPath;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['vote_average'] = voteAverage;
    map['fireBaseId'] = fireBaseId;
    return map;
  }
}
