import 'package:movies_app/core/network/remote/dio_helper.dart';
import 'package:movies_app/core/network/remote/end_points.dart';
import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';
import 'package:movies_app/feature/browse/data/models/movies_list_model/movies_list_model_response_model.dart';

abstract class BrowseRemoteDataSource {
  Future<List<Genres>> getMoviesList();
  Future<List<Results>> getMovieDiscover(int genreId);
}

class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource {
  BrowseRemoteDataSourceImpl();

  @override
  Future<List<Genres>> getMoviesList() async {
    final response = await DioHelper.getData(
      url: EndPoints.moviesList,
    );
    final moviesListModel = MoviesListModel.fromJson(response.data);
    return moviesListModel.genres ?? [];
  }

  @override
  Future<List<Results>> getMovieDiscover(int genreId) async {
    final response = await DioHelper.getData(
      url: EndPoints.movieDiscover,
      query: {'with_genres': genreId.toString()},
    );
    final discoverModel = MovieDiscoverModel.fromJson(response.data);
    return discoverModel.results ?? [];
  }
}
