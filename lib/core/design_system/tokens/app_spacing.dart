import 'package:flutter/material.dart';

abstract class AppSpacing {
  const AppSpacing._();

  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  // General layout spacing values
  static const double spacingMin = s;       // 8.0 (Low)
  static const double spacing = l;          // 16.0 (Normal)
  static const double spacingMax = xl;      // 24.0 (Max)

  static const EdgeInsets paddingAllXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingAllS = EdgeInsets.all(s);
  static const EdgeInsets paddingAllM = EdgeInsets.all(m);
  static const EdgeInsets paddingAllL = EdgeInsets.all(l);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingAllXxl = EdgeInsets.all(xxl);

  static const EdgeInsets paddingHorizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets paddingHorizontalM = EdgeInsets.symmetric(horizontal: m);
  static const EdgeInsets paddingHorizontalL = EdgeInsets.symmetric(horizontal: l);
  
  static const EdgeInsets paddingVerticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets paddingVerticalM = EdgeInsets.symmetric(vertical: m);
  static const EdgeInsets paddingVerticalL = EdgeInsets.symmetric(vertical: l);

  static const SizedBox verticalSpaceXs = SizedBox(height: xs);
  static const SizedBox verticalSpaceS = SizedBox(height: s);
  static const SizedBox verticalSpaceM = SizedBox(height: m);
  static const SizedBox verticalSpaceL = SizedBox(height: l);
  static const SizedBox verticalSpaceXl = SizedBox(height: xl);
  static const SizedBox verticalSpaceXxl = SizedBox(height: xxl);

  static const SizedBox horizontalSpaceXs = SizedBox(width: xs);
  static const SizedBox horizontalSpaceS = SizedBox(width: s);
  static const SizedBox horizontalSpaceM = SizedBox(width: m);
  static const SizedBox horizontalSpaceL = SizedBox(width: l);
  static const SizedBox horizontalSpaceXl = SizedBox(width: xl);
  static const SizedBox horizontalSpaceXxl = SizedBox(width: xxl);
}
