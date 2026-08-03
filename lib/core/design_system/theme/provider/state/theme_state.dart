import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  factory ThemeState({
    @Default(ThemeMode.system) ThemeMode themeMode,

    Color? seedColor,
  }) = _ThemeState;
}
