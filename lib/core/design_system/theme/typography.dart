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

  final textTheme = TextTheme(
    displayLarge: baseTextTheme.displayLarge?.copyWith(fontFamily: validDisplayFont),
    displayMedium: baseTextTheme.displayMedium?.copyWith(fontFamily: validDisplayFont),
    displaySmall: baseTextTheme.displaySmall?.copyWith(fontFamily: validDisplayFont),
    
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontFamily: validDisplayFont),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontFamily: validDisplayFont),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontFamily: validDisplayFont),
    
    titleLarge: baseTextTheme.titleLarge?.copyWith(fontFamily: validDisplayFont),
    titleMedium: baseTextTheme.titleMedium?.copyWith(fontFamily: validDisplayFont),
    titleSmall: baseTextTheme.titleSmall?.copyWith(fontFamily: validDisplayFont),
    
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: validBodyFont),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: validBodyFont),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: validBodyFont),
    
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: validBodyFont),
    labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: validBodyFont),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: validBodyFont),
  );

  return textTheme.apply(
    fontSizeFactor: getFontSizeFactor(fontSize),
  );
}
