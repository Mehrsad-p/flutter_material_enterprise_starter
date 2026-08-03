import 'package:flutter/material.dart';

abstract class AppTheme {
  const AppTheme._();

  static const Color _defaultSeedColor = Colors.deepPurple;

  static ThemeData build({
    Brightness brightness = Brightness.light,
    Color? seedColor,
    ColorScheme? dynamicColorScheme,
  }) {
    final colorScheme =
        dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor ?? _defaultSeedColor,
          brightness: brightness,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.surfaceContainerLow,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
