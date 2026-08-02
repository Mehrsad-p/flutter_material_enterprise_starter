import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/core/localization/app_locale.dart';

part 'locale_provider.g.dart';

@riverpod
class AppLocaleNotifier extends _$AppLocaleNotifier {
  @override
  Locale build() {
    return AppLocale.defaultLocale;
  }

  void setLocale(Locale locale) {
    if (!AppLocale.supportedLocales.contains(locale)) return;
    state = locale;
  }

  void toggleLocale() {
    state = state == AppLocale.fa ? AppLocale.en : AppLocale.fa;
  }
}
