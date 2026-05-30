import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';
import 'package:movies_app/feature/bookmarks/domain/usecases/get_favorites_usecase.dart';
import 'package:movies_app/feature/bookmarks/domain/usecases/add_favorite_usecase.dart';
import 'package:movies_app/feature/bookmarks/domain/usecases/delete_favorite_usecase.dart';

import 'bookmark_state.dart';

part 'bookmark_event.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final DeleteFavoriteUseCase deleteFavoriteUseCase;
  StreamSubscription? _favoritesSubscription;

  BookmarkBloc({
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.deleteFavoriteUseCase,
  }) : super(const BookmarkState()) {
    on<ListenFavoritesEvent>(_onListenFavorites);
    on<FavoritesUpdatedEvent>(_onFavoritesUpdated);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<DeleteFavoriteEvent>(_onDeleteFavorite);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onListenFavorites(
    ListenFavoritesEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(state.copyWith(
      status: LoadStatus.loading,
      error: '',
    ));
    _favoritesSubscription = getFavoritesUseCase().listen(
      (result) {
        result.fold(
          (failure) => add(FavoritesUpdatedEvent(
            favorites: const [],
            hasError: true,
            errorMessage: failure.message,
          )),
          (data) => add(FavoritesUpdatedEvent(
            favorites: data,
            hasError: false,
          )),
        );
      },
      onError: (error) {
        emit(state.copyWith(
          status: LoadStatus.error,
          error: error.toString(),
        ));
      },
    );
  }

  void _onFavoritesUpdated(
    FavoritesUpdatedEvent event,
    Emitter<BookmarkState> emit,
  ) {
    if (event.hasError) {
      emit(state.copyWith(
        status: LoadStatus.error,
        error: event.errorMessage,
      ));
    } else {
      emit(state.copyWith(
        status: LoadStatus.success,
        favorites: event.favorites,
      ));
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final result = await addFavoriteUseCase(event.movie);
    result.fold(
      (failure) => emit(state.copyWith(
        status: LoadStatus.error,
        error: failure.message,
      )),
      (_) {
        // Stream will automatically emit updated list
      },
    );
  }

  Future<void> _onDeleteFavorite(
    DeleteFavoriteEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final result = await deleteFavoriteUseCase(event.firebaseId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: LoadStatus.error,
        error: failure.message,
      )),
      (_) {
        // Stream will automatically emit updated list
      },
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    if (state.favoriteIds.contains(event.movieId)) {
      // Find the firebaseId of the existing favorite
      final existing = state.favorites.firstWhere((e) => e.id == event.movieId);
      if (existing.fireBaseId != null && existing.fireBaseId!.isNotEmpty) {
        await deleteFavoriteUseCase(existing.fireBaseId!);
      }
    } else {
      await addFavoriteUseCase(event.movie);
    }
    // No need to emit — the Firestore stream listener will pick up the change
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
