import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/views/home_view.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/presentation/views/launcher_view.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/pages/setting_body.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/pages/setting_page.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/pages/theme_color_picker_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_routes.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_page_transition.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.initial,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.initial,
        name: AppRoutes.initial,
        pageBuilder: (context, state) => AppPageTransition.slideHorizontal(
          key: state.pageKey,
          child: const Scaffold(body: LauncherView()),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,

        pageBuilder: (context, state) => AppPageTransition.slideHorizontal(
          key: state.pageKey,
          child: const Scaffold(body: HomeView()),
        ),
      ),

      // ── Settings ShellRoute ──────────────────────────────────────
      // SettingsPage is the shared Scaffold shell; sub-routes replace its body.
      ShellRoute(
        builder: (context, state, child) => SettingsPage(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.settings,
            name: AppRoutes.settings,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const SettingsBody()),
          ),
          GoRoute(
            path: AppRoutes.themeColor,
            name: AppRoutes.themeColor,
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const ThemeColorPickerBody()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
}
