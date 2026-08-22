import 'package:flutter/material.dart';

import 'package:flutter_material_enterprise_starter/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/presentation.dart';
import 'package:flutter_material_enterprise_starter/features/home/home.dart';
import 'package:flutter_material_enterprise_starter/features/launcher/launcher.dart';
import 'package:flutter_material_enterprise_starter/features/setting/setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_routes.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_page_transition.dart';

part 'app_router.g.dart';

/// Helper notifier to trigger GoRouter refresh whenever auth state changes.
class RouterTransitionNotifier extends ChangeNotifier {
  RouterTransitionNotifier(Ref ref) {
    ref.listen<AsyncValue<UserEntity?>>(authSessionControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.value != next.value) {
        notifyListeners();
      }
    });
  }
}

@riverpod
GoRouter appRouter(Ref ref) {
  final listenable = RouterTransitionNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.initial,
    debugLogDiagnostics: true,
    refreshListenable: listenable,
    redirect: (context, state) {
      final authSession = ref.read(authSessionControllerProvider);

      // Do not redirect while the authentication state is initializing
      if (authSession.isLoading) {
        return null;
      }

      final user = authSession.valueOrNull;
      final isAuthenticated = user != null;

      final isLoggingIn =
          state.matchedLocation == AppRoutes.auth ||
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register;

      if (isAuthenticated) {
        if (isLoggingIn || state.matchedLocation == AppRoutes.initial) {
          return AppRoutes.home;
        }
        return null;
      } else {
        if (state.matchedLocation == AppRoutes.auth) {
          return AppRoutes.login;
        }
        if (!isLoggingIn && state.matchedLocation != AppRoutes.initial) {
          return AppRoutes.login;
        }
        return null;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.initial,
        name: AppRoutes.initial,
        pageBuilder: (context, state) => AppPageTransition.slideHorizontal(
          key: state.pageKey,
          child: const Scaffold(body: LauncherView()),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => AuthView(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.login,
            name: AppRoutes.login,
            pageBuilder: (context, state) => NoTransitionPage(
              child: LoginView(
                onToggleView: () {
                  context.go(AppRoutes.register);
                },
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.register,
            name: AppRoutes.register,
            pageBuilder: (context, state) => NoTransitionPage(
              child: RegisterView(
                onToggleView: () {
                  context.go(AppRoutes.login);
                },
              ),
            ),
          ),
        ],
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
