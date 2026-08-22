import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/presentation.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/states/home_state.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/widgets/home_card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_routes.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.dashboard_title.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.goNamed(AppRoutes.initial),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.admin_panel_settings_rounded,
                        size: 48,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      AppSpacing.verticalSpaceS,
                      Text(
                        LocaleKeys.app_name.tr(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard_rounded),
                title: Text(LocaleKeys.dashboard_title.tr()),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.settings_rounded),
                title: Text(LocaleKeys.settings_title.tr()),
                onTap: () {
                  Navigator.pop(context);
                  context.push(AppRoutes.settings);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: Text(LocaleKeys.auth_logout_btn.tr()),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(authSessionControllerProvider.notifier).logout();
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          ),
          error: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: theme.colorScheme.error,
                  size: 48,
                ),
                AppSpacing.verticalSpaceL,
                Text(
                  message,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
                AppSpacing.verticalSpaceL,
                FilledButton.icon(
                  onPressed: () =>
                      ref.read(homeControllerProvider.notifier).loadDashboard(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(LocaleKeys.retry.tr()),
                ),
              ],
            ),
          ),
          success: (summary) => SingleChildScrollView(
            padding: AppSpacing.paddingAllXl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: AppSpacing.paddingAllXl,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: AppRadius.borderRadiusXl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        summary.welcomeMessage,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.verticalSpaceS,
                      Text(
                        LocaleKeys.dashboard_desc.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalSpaceXxl,
                Text(
                  LocaleKeys.dashboard_stats_title.tr(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.verticalSpaceL,
                HomeCardWidget(
                  title: LocaleKeys.active_users.tr(),
                  value: LocaleKeys.people_count.tr(
                    args: [summary.activeUsersCount.toString()],
                  ),
                  icon: Icons.people_alt_rounded,
                  color: theme.colorScheme.primary,
                ),
                AppSpacing.verticalSpaceL,
                HomeCardWidget(
                  title: LocaleKeys.pending_tasks.tr(),
                  value: LocaleKeys.tasks_count.tr(
                    args: [summary.pendingTasksCount.toString()],
                  ),
                  icon: Icons.task_alt_rounded,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
