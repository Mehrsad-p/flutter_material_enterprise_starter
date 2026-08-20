import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

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

  /// Automatically parses Dio and other server/network exceptions.
  factory Failure.fromException(dynamic e) {
    if (e is DioException) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        final rawMessage = data['message']?.toString();

        final String resolvedMessage;
        if (rawMessage == 'auth/invalid-credentials') {
          resolvedMessage = LocaleKeys.auth_invalid_credentials.tr();
        } else if (rawMessage == 'auth/email-already-in-use') {
          resolvedMessage = LocaleKeys.auth_email_already_in_use.tr();
        } else {
          resolvedMessage = rawMessage ?? LocaleKeys.error_server.tr();
        }

        return Failure.server(
          resolvedMessage,
          code: e.response!.statusCode,
          details: e.response!.data?.toString(),
        );
      } else {
        return Failure.server(
          e.message ?? LocaleKeys.error_connection.tr(),
          code: e.response?.statusCode ?? -1,
        );
      }
    }
    return Failure.server(e.toString());
  }

  /// Returns the localized error message representation.
  String get message {
    return when(
      server: (msg, code, details) => msg,
      cache: (msg) => msg ?? LocaleKeys.error_cache.tr(),
    );
  }
}
