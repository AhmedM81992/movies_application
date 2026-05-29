// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../utils/app_strings.dart';

class DioHelper {
  static late Dio dio;

  static init() {
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

      dio.interceptors.add(InterceptorsWrapper(
        onResponse: (response, handler) {
          if (response.statusCode != null && response.statusCode! >= 400) {
            debugPrint(
                '⚠️ Bad response: ${response.statusCode} ${response.statusMessage}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            debugPrint('⚠️ Slow network detected: ${error.message}');
          }
          handler.next(error);
        },
      ));
    } catch (e) {
      debugPrint("Dio Exception ::> $e");
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: query);

      response.data
          .toString()
          .split(",")
          // ignore: prefer_interpolation_to_compose_strings
          .forEach(
            (line) => debugPrint(
              "Data Received::>> ${'"' + line.replaceFirst(":", '":').replaceFirst("{", "").replaceFirst("}", "").replaceFirst("[", "").replaceFirst("]", "")},"
                  .replaceFirst('" ', '"'),
            ),
          );
      return response;
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
      final response = await dio.post(url, data: data);
      data
          .toString()
          .split(",")
          // ignore: prefer_interpolation_to_compose_strings
          .forEach(
            (line) => debugPrint(
              "Data Sent::>> ${'"' + line.replaceFirst(":", '":')},"
                  .replaceFirst('" ', '"'),
            ),
          );

      response.data
          .toString()
          .split(",")
          // ignore: prefer_interpolation_to_compose_strings
          .forEach(
            (line) => debugPrint(
              "Data Received::>> ${'"' + line.replaceFirst(":", '":')},"
                  .replaceFirst('" ', '"'),
            ),
          );

      return response;
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
}
