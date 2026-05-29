import 'package:movies_app/core/network/dio_helper.dart';
import 'package:movies_app/core/network/remote/end_points.dart';
import '../models/search_model/search_model_response_model.dart';

import 'search_remote_datasource.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl();

  @override
  Future<List<Results>> searchMovies(String query) async {
    final response = await DioHelper.getData(
      url: EndPoints.search,
      query: {'query': query},
    );
    final searchModel = SearchModel.fromJson(response.data);
    return searchModel.results ?? [];
  }
}
