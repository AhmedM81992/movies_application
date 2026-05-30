import 'package:bloc/bloc.dart';

import '../../../../../core/utils/load_status.dart';
import 'package:movies_app/feature/home/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/feature/home/domain/usecases/get_similar_movies_usecase.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetSimilarMoviesUseCase getSimilarMoviesUseCase;

  MovieDetailsBloc({
    required this.getMovieDetailsUseCase,
    required this.getSimilarMoviesUseCase,
  }) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
  }

  Future<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(
      detailsStatus: LoadStatus.loading,
      detailsError: '',
      similarStatus: LoadStatus.loading,
      similarError: '',
    ));

    final detailsResult = await getMovieDetailsUseCase(event.movieId);
    detailsResult.fold(
      (failure) => emit(state.copyWith(
        detailsStatus: LoadStatus.error,
        detailsError: failure.message,
      )),
      (data) => emit(state.copyWith(
        detailsStatus: LoadStatus.success,
        detailsResult: data,
      )),
    );

    final similarResult = await getSimilarMoviesUseCase(event.movieId);
    similarResult.fold(
      (failure) => emit(state.copyWith(
        similarStatus: LoadStatus.error,
        similarError: failure.message,
      )),
      (data) => emit(state.copyWith(
        similarStatus: LoadStatus.success,
        similarResults: data,
      )),
    );
  }
}
