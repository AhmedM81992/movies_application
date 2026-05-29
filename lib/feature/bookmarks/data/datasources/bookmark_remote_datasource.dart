import 'package:movies_app/feature/bookmarks/data/models/bookmark_movie/bookmark_movie_response_model.dart';

abstract class BookmarkRemoteDataSource {
  Stream<List<BookmarkMovieResponseModel>> getFavorites();
  Future<void> addFavorite(BookmarkMovieResponseModel movie);
  Future<void> deleteFavorite(String firebaseId);
}
