import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;
  final Dio dio;

  const AuthInterceptor(this.ref, this.dio);

  static const int _maxRetries = 15;
  static const int _retryDelaySeconds = 2;

  static Completer<bool>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      return token != null && token.isNotEmpty ? token : null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final retries = (err.requestOptions.extra['retries'] as int?) ?? 0;

    if (err.requestOptions.extra['isRefresh'] == true ||
        err.requestOptions.path.contains('/auth/refreshTokens')) {
      handler.next(err);
      return;
    }

    bool isAuthError = err.response?.statusCode == 401;
    if (!isAuthError &&
        err.response?.statusCode == 504 &&
        err.response?.data is Map) {
      final msg = err.response?.data['message']?.toString() ?? '';
      if (msg.contains('توکن نامعتبر') || msg.contains('token')) {
        isAuthError = true;
      }
    }

    if (isAuthError) {
      if (err.requestOptions.extra['is401Retried'] == true) {
        handler.reject(err);
        return;
      }

      bool refreshSucceeded = false;

      if (_refreshCompleter != null) {
        refreshSucceeded = await _refreshCompleter!.future;
      } else {
        _refreshCompleter = Completer<bool>();
        try {
          // Token refresh logic placeholder
          refreshSucceeded = false; 
          _refreshCompleter?.complete(false);
        } catch (e) {
          refreshSucceeded = false;
          if (_refreshCompleter?.isCompleted == false) {
            _refreshCompleter?.complete(false);
          }
        } finally {
          _refreshCompleter = null;
        }
      }

      if (refreshSucceeded) {
        try {
          final response = await _retry(err.requestOptions, is401Retried: true);
          handler.resolve(response);
        } catch (e) {
          handler.reject(
            e is DioException
                ? e
                : DioException(
                    requestOptions: err.requestOptions,
                    error: e,
                    type: DioExceptionType.connectionError,
                  ),
          );
        }
      } else {
        handler.reject(err);
      }
      return;
    }

    if (_isRetriableError(err) && retries < _maxRetries) {
      err.requestOptions.extra['retries'] = retries + 1;
      await Future.delayed(const Duration(seconds: _retryDelaySeconds));

      try {
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        handler.reject(
          e is DioException
              ? e
              : DioException(
                  requestOptions: err.requestOptions,
                  error: e,
                  type: DioExceptionType.connectionError,
                ),
        );
        return;
      }
    }

    handler.next(err);
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions, {
    bool is401Retried = false,
  }) async {
    final token = await _getToken();
    final mergedExtra = Map<String, dynamic>.from(requestOptions.extra);
    if (is401Retried) mergedExtra['is401Retried'] = true;

    final options = requestOptions.copyWith(extra: mergedExtra);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    try {
      return await dio.fetch(options);
    } catch (e) {
      if (e is DioException) rethrow;
      throw DioException(
        requestOptions: options,
        error: e,
        type: DioExceptionType.connectionError,
      );
    }
  }

  bool _isRetriableError(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;
  }
}
