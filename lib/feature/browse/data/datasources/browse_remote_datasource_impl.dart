import 'package:movies_app/core/network/dio_helper.dart';
import 'package:movies_app/core/network/remote/end_points.dart';
import '../models/movie_discover_model/movie_discover_model_response_model.dart';
import '../models/movies_list_model/movies_list_model_response_model.dart';

import 'browse_remote_datasource.dart';

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
