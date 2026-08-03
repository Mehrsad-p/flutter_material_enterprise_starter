import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/state/theme_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class AppThemeNotifier extends _$AppThemeNotifier {
  @override
  ThemeState build() {
    return ThemeState();
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setSeedColor(Color color) {
    state = state.copyWith(seedColor: color);
  }

  void toggleTheme() {
    state = state.copyWith(
      themeMode: state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
