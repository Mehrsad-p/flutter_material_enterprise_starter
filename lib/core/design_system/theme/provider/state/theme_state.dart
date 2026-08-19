import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

enum FontSize { small, medium, large }

@freezed
abstract class AppThemeFonts with _$AppThemeFonts {
  const factory AppThemeFonts({
    @Default('IRANSans') String bodyFont,
    @Default('IRANSans') String displayFont,
  }) = _AppThemeFonts;
}

@freezed
abstract class ThemeState with _$ThemeState {
  factory ThemeState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    Color? seedColor,
    @Default(AppThemeFonts()) AppThemeFonts fonts,
    @Default(FontSize.medium) FontSize fontSize,
  }) = _ThemeState;
}
