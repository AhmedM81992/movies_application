import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('====================================================');
    debugPrint('🌍 [REQUEST] [${options.method}] ${options.uri}');
    debugPrint('📋 [HEADERS] ${options.headers}');
    if (options.data != null) {
      debugPrint('📤 [BODY]\n${_prettyJson(options.data)}');
    }
    debugPrint('====================================================');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('====================================================');
    debugPrint('✅ [RESPONSE] [${response.statusCode}] ${response.requestOptions.uri}');
    debugPrint('📥 [DATA]\n${_prettyJson(response.data)}');
    debugPrint('====================================================');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('====================================================');
    debugPrint('❌ [ERROR] [${err.response?.statusCode}] ${err.requestOptions.uri}');
    debugPrint('🚨 [MESSAGE] ${err.message}');
    if (err.response?.data != null) {
      debugPrint('📥 [ERROR DATA]\n${_prettyJson(err.response?.data)}');
    }
    debugPrint('====================================================');
    super.onError(err, handler);
  }

  String _prettyJson(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      if (data is String) {
        final decoded = jsonDecode(data);
        return const JsonEncoder.withIndent('  ').convert(decoded);
      }
      return data.toString();
    } catch (e) {
      return data.toString();
    }
  }
}
