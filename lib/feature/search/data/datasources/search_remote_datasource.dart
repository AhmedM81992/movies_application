import 'package:movies_app/feature/search/data/models/search_model/search_model_response_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<Results>> searchMovies(String query);
}
