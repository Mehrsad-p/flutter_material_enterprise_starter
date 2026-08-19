import 'package:flutter/material.dart';

/// Reusable utility extensions for [Color] manipulation.
extension ColorHexExtension on Color {
  /// Converts the color to a safe hex string.
  /// If the color is semi-transparent, it outputs 8-character ARGB hex (e.g., #806750A4).
  /// If it is fully opaque, it outputs 6-character hex (e.g., #6750A4).
  String toHex() {
    final alphaVal = (a * 255.0).round().clamp(0, 255);
    final redVal = (r * 255.0).round().clamp(0, 255);
    final greenVal = (g * 255.0).round().clamp(0, 255);
    final blueVal = (b * 255.0).round().clamp(0, 255);

    final hexA = alphaVal.toRadixString(16).padLeft(2, '0');
    final hexR = redVal.toRadixString(16).padLeft(2, '0');
    final hexG = greenVal.toRadixString(16).padLeft(2, '0');
    final hexB = blueVal.toRadixString(16).padLeft(2, '0');

    if (alphaVal == 255) {
      return '#$hexR$hexG$hexB'.toUpperCase();
    } else {
      return '#$hexA$hexR$hexG$hexB'.toUpperCase();
    }
  }
}
