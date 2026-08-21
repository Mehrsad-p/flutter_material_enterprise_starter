import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server(
    String customMessage, {
    int? code,
    String? details,
  }) = ServerFailure;

  const factory Failure.cache([String? customMessage]) = CacheFailure;

  /// Automatically parses Dio and other server/network exceptions into pure data-driven failures.
  factory Failure.fromException(dynamic e) {
    if (e is DioException) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        final rawMessage = data['message']?.toString();

        return Failure.server(
          rawMessage ?? 'error.server',
          code: e.response!.statusCode,
          details: e.response!.data?.toString(),
        );
      } else {
        return Failure.server(
          e.message ?? 'error.connection',
          code: e.response?.statusCode ?? -1,
        );
      }
    }
    return Failure.server(e.toString());
  }

  /// Returns the raw machine-readable error code or message key.
  String get message {
    return when(
      server: (msg, code, details) => msg,
      cache: (msg) => msg ?? 'error.cache',
    );
  }
}

