import 'package:flutter/material.dart';

abstract class AppRadius {
  const AppRadius._();

  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double circular = 999.0;

  static final BorderRadius borderRadiusXs = BorderRadius.circular(xs);
  static final BorderRadius borderRadiusS = BorderRadius.circular(s);
  static final BorderRadius borderRadiusM = BorderRadius.circular(m);
  static final BorderRadius borderRadiusL = BorderRadius.circular(l);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(xl);
  static final BorderRadius borderRadiusCircular = BorderRadius.circular(
    circular,
  );
}
