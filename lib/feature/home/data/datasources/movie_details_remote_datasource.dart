import 'package:movies_app/core/network/remote/dio_helper.dart';
import '../../../../core/network/remote/end_points.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/similar_to_model/similar_to_model_response_model.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<DetailsModel> getDetails(int movieId);
  Future<List<Results>> getSimilar(int movieId);
}

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final DioHelper dioHelper;
  MovieDetailsRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<DetailsModel> getDetails(int movieId) async {
    final response = await dioHelper.getData(
      url: '${EndPoints.details}$movieId',
    );
    return DetailsModel.fromJson(response.data);
  }

  @override
  Future<List<Results>> getSimilar(int movieId) async {
    final response = await dioHelper.getData(
      url: '${EndPoints.details}$movieId${EndPoints.similar}',
    );
    final similarModel = SimilarToModel.fromJson(response.data);
    return similarModel.results ?? [];
  }
}
