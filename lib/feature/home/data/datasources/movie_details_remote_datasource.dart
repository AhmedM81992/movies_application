import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<DetailsModel> getDetails(int movieId);
  Future<List<Results>> getSimilar(int movieId);
}
