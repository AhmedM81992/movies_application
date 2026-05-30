import 'package:get_it/get_it.dart';

import '../../feature/browse/data/datasources/browse_remote_datasource.dart';
import '../../feature/browse/data/repositories_impl/browse_repository_impl.dart';
import '../../feature/browse/domain/repositories/browse_repository.dart';
import '../../feature/browse/domain/usecases/get_genres_usecase.dart';
import '../../feature/browse/domain/usecases/get_movie_discover_usecase.dart';
import '../../feature/browse/presentation/business_logic/bloc/browse_bloc.dart';
import '../../feature/home/data/datasources/home_local_datasource.dart';
import '../../feature/home/data/datasources/home_remote_datasource.dart';
import '../../feature/home/data/datasources/movie_details_local_datasource.dart';
import '../../feature/home/data/datasources/movie_details_remote_datasource.dart';
import '../../feature/home/data/repositories_impl/home_repository_impl.dart';
import '../../feature/home/data/repositories_impl/movie_details_repository_impl.dart';
import '../../feature/home/domain/repositories/home_repository.dart';
import '../../feature/home/domain/repositories/movie_details_repository.dart';
import '../../feature/home/domain/usecases/get_details_usecase.dart';
import '../../feature/home/domain/usecases/get_movie_details_usecase.dart';
import '../../feature/home/domain/usecases/get_popular_usecase.dart';
import '../../feature/home/domain/usecases/get_similar_movies_usecase.dart';
import '../../feature/home/domain/usecases/get_top_rated_usecase.dart';
import '../../feature/home/domain/usecases/get_upcoming_usecase.dart';
import '../../feature/home/presentation/business_logic/bloc/home_screen_bloc.dart';
import '../../feature/home/presentation/business_logic/bloc/movie_details_bloc.dart';
import '../../feature/bookmarks/data/datasources/bookmark_remote_datasource.dart';
import '../../feature/bookmarks/data/repositories_impl/bookmark_repository_impl.dart';
import '../../feature/bookmarks/domain/repositories/bookmark_repository.dart';
import '../../feature/bookmarks/domain/usecases/get_favorites_usecase.dart';
import '../../feature/bookmarks/domain/usecases/add_favorite_usecase.dart';
import '../../feature/bookmarks/domain/usecases/delete_favorite_usecase.dart';
import '../../feature/bookmarks/presentation/business_logic/bloc/bookmark_bloc.dart';
import '../../feature/home/presentation/business_logic/cubit/bottom_nav_cubit.dart';
import '../../feature/search/data/datasources/search_remote_datasource.dart';
import '../../feature/search/data/repositories_impl/search_repository_impl.dart';
import '../../feature/search/domain/repositories/search_repository.dart';
import '../../feature/search/domain/usecases/search_movies_usecase.dart';
import '../../feature/search/presentation/business_logic/bloc/search_bloc.dart';
import '../network/remote/api_manager.dart';
import '../network/remote/dio_helper.dart';
import '../network/local/app_database_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/check_connectivity/cubit/connectivity_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize DioHelper's static Dio instance before any network calls
  DioHelper.init();

  // Core network services
  sl.registerLazySingleton<DioHelper>(() => DioHelper());
  sl.registerLazySingleton<ApiManager>(() => ApiManager());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // Shared local database
  sl.registerLazySingleton<AppDatabaseHelper>(() => AppDatabaseHelper());

  // Datasources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioHelper: sl()));
  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
      () => MovieDetailsRemoteDataSourceImpl(dioHelper: sl()));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(dioHelper: sl()));
  sl.registerLazySingleton<BrowseRemoteDataSource>(
      () => BrowseRemoteDataSourceImpl(dioHelper: sl()));
  sl.registerLazySingleton<BookmarkRemoteDataSource>(
      () => BookmarkRemoteDataSourceImpl());

  // Local datasources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(appDb: sl()),
  );
  sl.registerLazySingleton<MovieDetailsLocalDataSource>(
    () => MovieDetailsLocalDataSourceImpl(appDb: sl()),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<MovieDetailsRepository>(() =>
      MovieDetailsRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<BrowseRepository>(
      () => BrowseRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepositoryImpl(remoteDataSource: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetPopularUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingUseCase(sl()));
  sl.registerLazySingleton(() => GetTopRatedUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetSimilarMoviesUseCase(sl()));
  sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetGenresUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieDiscoverUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFavoriteUseCase(sl()));

  // Feature BLoCs
  sl.registerFactory<HomeScreenBloc>(() => HomeScreenBloc(
        getPopularUseCase: sl(),
        getUpcomingUseCase: sl(),
        getTopRatedUseCase: sl(),
        getDetailsUseCase: sl(),
      ));
  sl.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(
        getMovieDetailsUseCase: sl(),
        getSimilarMoviesUseCase: sl(),
      ));
  sl.registerFactory<SearchBloc>(() => SearchBloc(searchMoviesUseCase: sl()));
  sl.registerFactory<BrowseBloc>(() => BrowseBloc(
        getGenresUseCase: sl(),
        getMovieDiscoverUseCase: sl(),
      ));
  sl.registerLazySingleton<BookmarkBloc>(() => BookmarkBloc(
        getFavoritesUseCase: sl(),
        addFavoriteUseCase: sl(),
        deleteFavoriteUseCase: sl(),
      ));

  // Cubits
  sl.registerFactory<BottomNavCubit>(() => BottomNavCubit());
  sl.registerFactory<ConnectivityCubit>(
    () => ConnectivityCubit(connectivity: sl()),
  );
}
