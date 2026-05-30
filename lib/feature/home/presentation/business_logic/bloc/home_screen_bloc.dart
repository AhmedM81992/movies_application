import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/load_status.dart';
import 'package:movies_app/feature/home/domain/usecases/get_details_usecase.dart';
import 'package:movies_app/feature/home/domain/usecases/get_popular_usecase.dart';
import 'package:movies_app/feature/home/domain/usecases/get_top_rated_usecase.dart';
import 'package:movies_app/feature/home/domain/usecases/get_upcoming_usecase.dart';
import 'home_screen_state.dart';

part 'home_screen_event.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final GetPopularUseCase getPopularUseCase;
  final GetUpcomingUseCase getUpcomingUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;
  final GetDetailsUseCase getDetailsUseCase;

  HomeScreenBloc({
    required this.getPopularUseCase,
    required this.getUpcomingUseCase,
    required this.getTopRatedUseCase,
    required this.getDetailsUseCase,
  }) : super(HomeScreenState.initial()) {
    on<GetHomePopularEvent>(_getPopular);
    on<GetHomeUpcomingEvent>(_getUpcoming);
    on<GetHomeTopRatedEvent>(_getTopRated);
    on<GetHomeDetailsEvent>(_getDetails);
  }

  Future<void> _getPopular(
      GetHomePopularEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(
      popularStatus: LoadStatus.loading,
      popularError: null,
    ));
    final result = await getPopularUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        popularStatus: LoadStatus.error,
        popularError: failure.message,
      )),
      (data) => emit(state.copyWith(
        popularStatus: LoadStatus.success,
        popularResults: data,
      )),
    );
  }

  Future<void> _getUpcoming(
      GetHomeUpcomingEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(
      upcomingStatus: LoadStatus.loading,
      upcomingError: null,
    ));
    final result = await getUpcomingUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        upcomingStatus: LoadStatus.error,
        upcomingError: failure.message,
      )),
      (data) => emit(state.copyWith(
        upcomingStatus: LoadStatus.success,
        upcomingResults: data,
      )),
    );
  }

  Future<void> _getTopRated(
      GetHomeTopRatedEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(
      topRatedStatus: LoadStatus.loading,
      topRatedError: null,
    ));
    final result = await getTopRatedUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        topRatedStatus: LoadStatus.error,
        topRatedError: failure.message,
      )),
      (data) => emit(state.copyWith(
        topRatedStatus: LoadStatus.success,
        topRatedResults: data,
      )),
    );
  }

  Future<void> _getDetails(
      GetHomeDetailsEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(
      detailsStatus: LoadStatus.loading,
      detailsError: null,
    ));
    final result = await getDetailsUseCase(event.movieId);
    result.fold(
      (failure) => emit(state.copyWith(
        detailsStatus: LoadStatus.error,
        detailsError: failure.message,
      )),
      (data) => emit(state.copyWith(
        detailsStatus: LoadStatus.success,
        detailsResult: data,
      )),
    );
  }
}
