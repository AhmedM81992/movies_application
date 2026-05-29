import '../../../../core/components/constants.dart';
import 'package:movies_app/core/network/remote/dio_helper.dart';
import '../../../../core/network/remote/end_points.dart';
import '../models/details_model/details_model_response_model.dart';
import '../models/popular_model/popular_model_response_model.dart';
import '../models/results_model/results_model_response_model.dart';
import '../models/top_rated_model/top_rated_model_response_model.dart';
import '../models/upcoming_model/upcoming_model_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<Results>> getPopular();
  Future<List<Results>> getUpcoming();
  Future<List<Results>> getTopRated();
  Future<DetailsModel> getDetails(int movieId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl();

  @override
  Future<List<Results>> getPopular() async {
    final response = await DioHelper.getData(
      url: EndPoints.popular,
      query: {'apiKey': Constants.apiKey},
    );
    final popularModel = PopularModel.fromJson(response.data);
    return popularModel.results ?? [];
  }

  @override
  Future<List<Results>> getUpcoming() async {
    final response = await DioHelper.getData(
      url: EndPoints.upComing,
      query: {'apiKey': Constants.apiKey},
    );
    final upcomingModel = UpcomingModel.fromJson(response.data);
    return upcomingModel.results ?? [];
  }

  @override
  Future<List<Results>> getTopRated() async {
    final response = await DioHelper.getData(
      url: EndPoints.topRated,
      query: {'apiKey': Constants.apiKey},
    );
    final topRatedModel = TopRatedModel.fromJson(response.data);
    return topRatedModel.results ?? [];
  }

  @override
  Future<DetailsModel> getDetails(int movieId) async {
    final response = await DioHelper.getData(
      url: '${EndPoints.details}$movieId',
    );
    return DetailsModel.fromJson(response.data);
  }
}
