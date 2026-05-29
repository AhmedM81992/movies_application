// ignore: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/search/domain/usecases/search_movies_usecase.dart';

import 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;
  Timer? _debounce;

  SearchBloc({required this.searchMoviesUseCase}) : super(const SearchState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    _debounce?.cancel();

    if (event.query.isEmpty) {
      emit(state.copyWith(status: LoadStatus.initial, results: []));
      return;
    }

    emit(state.copyWith(query: event.query));

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(state.copyWith(status: LoadStatus.loading, results: []));

      final result = await searchMoviesUseCase(event.query);
      result.fold(
        (failure) => emit(state.copyWith(
          status: LoadStatus.error,
          error: failure.message,
        )),
        (data) => emit(state.copyWith(
          status: LoadStatus.success,
          results: data,
        )),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
