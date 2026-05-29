import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/core/services/custom_firebase_messaging_service.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

class BookmarkState {
  final List<Results> favList;
  final LoadStatus status;
  final String? error;

  const BookmarkState({
    this.favList = const [],
    this.status = LoadStatus.initial,
    this.error,
  });

  BookmarkState copyWith({
    List<Results>? favList,
    LoadStatus? status,
    String? error,
  }) {
    return BookmarkState(
      favList: favList ?? this.favList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

class BookmarkCubit extends Cubit<BookmarkState> {
  StreamSubscription<QuerySnapshot<Results>>? _subscription;

  BookmarkCubit() : super(const BookmarkState()) {
    _listenFavorites();
  }

  void _listenFavorites() {
    emit(state.copyWith(status: LoadStatus.loading));
    _subscription = FireBaseFunctions.getFavorites().listen(
      (snapshot) {
        final favList = snapshot.docs.map((e) => e.data()).toList();
        emit(state.copyWith(favList: favList, status: LoadStatus.success));
      },
      onError: (error) {
        emit(state.copyWith(
          status: LoadStatus.error,
          error: error.toString(),
        ));
      },
    );
  }

  /// Returns true if the movie with the given [movieId] is in the favorites list.
  bool isFavorite(int movieId) {
    return state.favList.any((element) => element.id == movieId);
  }

  /// Toggles the favorite status of [movie].
  /// If already a favorite, removes it. Otherwise, adds it.
  void toggleFavorite(Results movie) {
    final movieId = movie.id ?? 0;

    if (isFavorite(movieId)) {
      final fav = state.favList.firstWhere((e) => e.id == movieId);
      if (fav.fireBaseId != null && fav.fireBaseId!.isNotEmpty) {
        FireBaseFunctions.deleteFavorites(fav.fireBaseId!);
      }
    } else {
      FireBaseFunctions.addMovie(movie);
    }
    // No need to emit manually — the Firestore stream listener will
    // automatically pick up the change and emit an updated state.
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
