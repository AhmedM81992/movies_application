import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/browse/domain/usecases/get_genres_usecase.dart';
import 'package:movies_app/feature/browse/domain/usecases/get_movie_discover_usecase.dart';

import 'browse_state.dart';

part 'browse_event.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final GetGenresUseCase getGenresUseCase;
  final GetMovieDiscoverUseCase getMovieDiscoverUseCase;

  BrowseBloc({
    required this.getGenresUseCase,
    required this.getMovieDiscoverUseCase,
  }) : super(const BrowseState()) {
    on<GetGenresEvent>(_onGetGenres);
    on<GetMovieDiscoverEvent>(_onGetMovieDiscover);
  }

  Future<void> _onGetGenres(
    GetGenresEvent event,
    Emitter<BrowseState> emit,
  ) async {
    emit(state.copyWith(
      genresStatus: LoadStatus.loading,
      genresError: '',
    ));
    final result = await getGenresUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        genresStatus: LoadStatus.error,
        genresError: failure.message,
      )),
      (data) => emit(state.copyWith(
        genresStatus: LoadStatus.success,
        genres: data,
      )),
    );
  }

  Future<void> _onGetMovieDiscover(
    GetMovieDiscoverEvent event,
    Emitter<BrowseState> emit,
  ) async {
    emit(state.copyWith(
      discoverStatus: LoadStatus.loading,
      discoverError: '',
    ));
    final result = await getMovieDiscoverUseCase(event.genreId);
    result.fold(
      (failure) => emit(state.copyWith(
        discoverStatus: LoadStatus.error,
        discoverError: failure.message,
      )),
      (data) => emit(state.copyWith(
        discoverStatus: LoadStatus.success,
        discoverResults: data,
      )),
    );
  }
}
