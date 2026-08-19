import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_material_enterprise_starter/core/network/interceptors/auth_interceptor.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();

  final authInterceptor = AuthInterceptor(ref, dio);

  final loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true),
  );

  dio.options.baseUrl = 'https://api.example.com/';
  dio.options.responseType = ResponseType.json;
  dio.options.contentType = Headers.jsonContentType;
  dio.options.connectTimeout = const Duration(milliseconds: 30000);
  dio.options.receiveTimeout = const Duration(milliseconds: 30000);

  // Cache configuration
  final cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
  final cacheOptions = CacheOptions(
    store: cacheStore,
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: [401, 403],
    maxStale: const Duration(days: 1),
    priority: CachePriority.high,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );

  dio.interceptors.add(authInterceptor);
  dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        responseHeader: false,
        requestHeader: false,
        error: true,
        request: false,
        logPrint: (Object object) {
          loggerNoStack.i(object);
        },
      ),
    );
  }

  return dio;
}
