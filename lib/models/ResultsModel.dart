import 'DetailsModel.dart';

class Results {
  Results({
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

  Results.fromDetailsModel(DetailsModel detailsModel) {
    // Convert DetailsModel fields to Results fields
    fireBaseId = ''; // Assuming fireBaseId is not part of DetailsModel
    adult = detailsModel.adult;
    backdropPath = detailsModel.backdropPath;
    genreIds = []; // Assuming genreIds is not part of DetailsModel
    id = detailsModel.id;
    originalLanguage = detailsModel.originalLanguage;
    originalTitle = detailsModel.originalTitle;
    overview = detailsModel.overview;
    popularity = detailsModel.popularity;
    posterPath = detailsModel.posterPath;
    releaseDate = detailsModel.releaseDate;
    title = detailsModel.title;
    video = detailsModel.video;
    voteAverage = detailsModel.voteAverage;
    voteCount = detailsModel.voteCount;
  }

  Results.fromJson(dynamic json) {
    fireBaseId = json['fireBaseId'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  String? fireBaseId;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fireBaseId'] = fireBaseId;
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}
