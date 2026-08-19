import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/state/theme_state.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/typography.dart';

abstract class AppTheme {
  const AppTheme._();

  static const Color _defaultSeedColor = Colors.deepPurple;

  static ThemeData build({
    Brightness brightness = Brightness.light,
    Color? seedColor,
    ColorScheme? dynamicColorScheme,
    required AppThemeFonts fonts,
    required FontSize fontSize,
  }) {
    final colorScheme =
        dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor ?? _defaultSeedColor,
          brightness: brightness,
        );

    final textTheme = createTextTheme(
      fonts.bodyFont,
      fonts.displayFont,
      fontSize,
      brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
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
