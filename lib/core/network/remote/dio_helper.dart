import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../utils/app_strings.dart';

class DioHelper {
  static late Dio dio;

  static init() {
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
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.get(url, queryParameters: query);
    } on Exception catch (e) {
      debugPrint("Dio Exception ::> $e");
      rethrow;
    }
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      data
          .toString()
          .split(",")
          // ignore: prefer_interpolation_to_compose_strings
          .forEach((line) => debugPrint(
              "Data Sent::>> ${'"' + line.replaceFirst(":", '":')},"
                  .replaceFirst('" ', '"')));
      return await dio.post(url, data: data);
    } on Exception catch (e) {
      debugPrint("Dio Exception ::> $e");
      rethrow;
    }
  }

  static Future<Response> postDataMapList({
    required String url,
    List<Map<String, Object?>>? data,
  }) async {
    try {
      // data
      //     .toString()
      //     .split(",")
      //     // ignore: prefer_interpolation_to_compose_strings
      //     .forEach((line) => debugPrint("Data Sent::>> ${'"' + line.replaceFirst(":", '":')},"
      //         .replaceFirst('" ', '"')));
      return await dio.post(url, data: data);
    } on Exception catch (e) {
      debugPrint("Dio Exception ::> $e");
      rethrow;
    }
  }
}
