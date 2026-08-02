import 'package:flutter/material.dart';

abstract class AppLocale {
  const AppLocale._();

  static const Locale fa = Locale('fa');
  static const Locale en = Locale('en');

  static const List<Locale> supportedLocales = [fa, en];

  static const Locale defaultLocale = fa;
}
