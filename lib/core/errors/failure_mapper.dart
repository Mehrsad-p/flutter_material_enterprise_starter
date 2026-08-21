import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/errors/failure.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

extension FailureMapperExtension on Object {
  /// Maps a pure data-driven [Failure] or Exception to a localized user-facing String.
  String toLocalizedMessage(BuildContext context) {
    final error = this;
    if (error is Failure) {
      return error.when(
        server: (customMessage, code, details) {
          if (customMessage == 'auth/invalid-credentials') {
            return LocaleKeys.auth_invalid_credentials.tr();
          } else if (customMessage == 'auth/email-already-in-use') {
            return LocaleKeys.auth_email_already_in_use.tr();
          }
          return customMessage.isNotEmpty
              ? customMessage
              : LocaleKeys.error_server.tr();
        },
        cache: (customMessage) =>
            customMessage ?? LocaleKeys.error_cache.tr(),
      );
    }
    return LocaleKeys.error_server.tr();
  }
}
