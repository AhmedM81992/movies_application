// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../utils/app_strings.dart';
import 'dio_interceptor.dart';
import 'slow_network_interceptor.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: Constants.baseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': AppStrings.headerApiKey!,
          },
        ),
      );

      dio.interceptors.add(SlowNetworkInterceptor());
      dio.interceptors.add(LoggerInterceptor());
    } catch (e) {
      debugPrint("Dio Exception ::> $e");
    }
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: query);
      return response;
    } on Exception catch (e) {
      debugPrint("Dio Exception ::> $e");
      rethrow;
    }
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } on Exception catch (e) {
      debugPrint("Dio Exception ::> $e");
      rethrow;
    }
  }

  Future<Response> postDataMapList({
    required String url,
    List<Map<String, Object?>>? data,
  }) async {
    try {
      return await dio.post(url, data: data);
    } on Exception catch (e) {
      debugPrint("Dio Exception ::> $e");
      rethrow;
    }
  }
}
