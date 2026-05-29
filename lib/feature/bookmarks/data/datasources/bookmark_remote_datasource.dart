import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bookmark_movie/bookmark_movie_response_model.dart';

abstract class BookmarkRemoteDataSource {
  Stream<List<BookmarkMovieResponseModel>> getFavorites();
  Future<void> addFavorite(BookmarkMovieResponseModel movie);
  Future<void> deleteFavorite(String firebaseId);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  BookmarkRemoteDataSourceImpl();

  @override
  Stream<List<BookmarkMovieResponseModel>> getFavorites() {
    return FirebaseFirestore.instance.collection('Fav').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => BookmarkMovieResponseModel.fromJson(
                  doc.data(),
                  fireBaseId: doc.id,
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> addFavorite(BookmarkMovieResponseModel movie) async {
    final doc = FirebaseFirestore.instance.collection('Fav').doc();
    final data = movie.toJson();
    data.remove('fireBaseId');
    await doc.set(data);
  }

  @override
  Future<void> deleteFavorite(String firebaseId) async {
    await FirebaseFirestore.instance.collection('Fav').doc(firebaseId).delete();
  }
}
