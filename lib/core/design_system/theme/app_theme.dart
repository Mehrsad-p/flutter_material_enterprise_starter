import 'package:flutter/material.dart';

abstract class AppTheme {
  const AppTheme._();

  static const Color _defaultSeedColor = Colors.deepPurple;

  /// تم روشن (Light Theme)
  static ThemeData light(ColorScheme? dynamicColorScheme) {
    final colorScheme =
        dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: _defaultSeedColor,
          brightness: Brightness.light,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
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

  /// تم تاریک (Dark Theme)
  static ThemeData dark(ColorScheme? dynamicColorScheme) {
    final colorScheme =
        dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: _defaultSeedColor,
          brightness: Brightness.dark,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
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
