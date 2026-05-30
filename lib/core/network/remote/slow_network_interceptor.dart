import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SlowNetworkInterceptor extends Interceptor {
  final Map<RequestOptions, Timer> _activeTimers = {};
  final Duration threshold;

  SlowNetworkInterceptor({this.threshold = const Duration(seconds: 8)});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timer = Timer(threshold, () {
      debugPrint('⚠️ [SLOW NETWORK] Request taking too long: ${options.path}');
    });
    _activeTimers[options] = timer;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _activeTimers.remove(response.requestOptions)?.cancel();
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _activeTimers.remove(err.requestOptions)?.cancel();
    super.onError(err, handler);
  }
}
