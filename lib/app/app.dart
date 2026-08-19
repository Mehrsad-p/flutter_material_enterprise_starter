// lib/app/app.dart
import 'package:flutter/material.dart';

import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_router.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeState = ref.watch(appThemeNotifierProvider);

    return MaterialApp.router(
      title: 'Enterprise Starter',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.build(
        brightness: Brightness.light,
        seedColor: themeState.seedColor,
        fonts: themeState.fonts,
        fontSize: themeState.fontSize,
      ),
      darkTheme: AppTheme.build(
        brightness: Brightness.dark,
        seedColor: themeState.seedColor,
        fonts: themeState.fonts,
        fontSize: themeState.fontSize,
      ),
      themeMode: themeState.themeMode,

      routerConfig: router,
    );
  }
}
