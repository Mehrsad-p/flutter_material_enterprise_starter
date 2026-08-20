import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/state/theme_state.dart';

abstract class Fonts {
  Fonts._();

  static const String iranYekanX = 'IRANYekanX';
  static const String iranSans = 'IRANSans';
}

double getFontSizeFactor(FontSize fontSize) {
  switch (fontSize) {
    case FontSize.small:
      return 0.8;
    case FontSize.medium:
      return 1.0;
    case FontSize.large:
      return 1.2;
  }
}

TextTheme createTextTheme(
  String bodyFontString,
  String displayFontString,
  FontSize fontSize,
  Brightness brightness,
) {
  final TextTheme baseTextTheme = ThemeData(brightness: brightness).textTheme;

  const List<String> localFonts = [Fonts.iranYekanX, Fonts.iranSans];
  final String validBodyFont = localFonts.contains(bodyFontString)
      ? bodyFontString
      : Fonts.iranSans;
  final String validDisplayFont = localFonts.contains(displayFontString)
      ? displayFontString
      : Fonts.iranSans;

  final factor = getFontSizeFactor(fontSize);

  TextStyle? scale(TextStyle? style, double defaultSize) {
    if (style == null) return null;
    final size = style.fontSize ?? defaultSize;
    return style.copyWith(fontSize: size * factor);
  }

  return TextTheme(
    displayLarge: scale(baseTextTheme.displayLarge?.copyWith(fontFamily: validDisplayFont), 57),
    displayMedium: scale(baseTextTheme.displayMedium?.copyWith(fontFamily: validDisplayFont), 45),
    displaySmall: scale(baseTextTheme.displaySmall?.copyWith(fontFamily: validDisplayFont), 36),
    
    headlineLarge: scale(baseTextTheme.headlineLarge?.copyWith(fontFamily: validDisplayFont), 32),
    headlineMedium: scale(baseTextTheme.headlineMedium?.copyWith(fontFamily: validDisplayFont), 28),
    headlineSmall: scale(baseTextTheme.headlineSmall?.copyWith(fontFamily: validDisplayFont), 24),
    
    titleLarge: scale(baseTextTheme.titleLarge?.copyWith(fontFamily: validDisplayFont), 22),
    titleMedium: scale(baseTextTheme.titleMedium?.copyWith(fontFamily: validDisplayFont), 16),
    titleSmall: scale(baseTextTheme.titleSmall?.copyWith(fontFamily: validDisplayFont), 14),
    
    bodyLarge: scale(baseTextTheme.bodyLarge?.copyWith(fontFamily: validBodyFont), 16),
    bodyMedium: scale(baseTextTheme.bodyMedium?.copyWith(fontFamily: validBodyFont), 14),
    bodySmall: scale(baseTextTheme.bodySmall?.copyWith(fontFamily: validBodyFont), 12),
    
    labelLarge: scale(baseTextTheme.labelLarge?.copyWith(fontFamily: validBodyFont), 14),
    labelMedium: scale(baseTextTheme.labelMedium?.copyWith(fontFamily: validBodyFont), 12),
    labelSmall: scale(baseTextTheme.labelSmall?.copyWith(fontFamily: validBodyFont), 11),
  );
}
