import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/views/home_view.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/presentation/views/launcher_view.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/pages/setting_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_routes.dart';

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
        builder: (context, state) => const Scaffold(body: LauncherView()),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const Scaffold(body: HomeView()),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
}
