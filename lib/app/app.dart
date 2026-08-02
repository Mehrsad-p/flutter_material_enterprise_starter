// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/core/localization/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_router.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/app_theme.dart';
import 'package:flutter_material_enterprise_starter/core/localization/locale_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(appLocaleNotifierProvider);
    final themeMode = ref.watch(appThemeNotifierProvider);

    return MaterialApp.router(
      title: 'Enterprise Starter',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.light(null),
      darkTheme: AppTheme.dark(null),
      themeMode: themeMode,

      // Localization configuration
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      // Router configuration
      routerConfig: router,
    );
  }
}
