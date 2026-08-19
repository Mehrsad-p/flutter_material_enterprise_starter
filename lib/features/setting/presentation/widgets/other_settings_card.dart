import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_routes.dart';

class OtherSettingsCard extends ConsumerWidget {
  const OtherSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(appThemeNotifierProvider);
    final themeNotifier = ref.read(appThemeNotifierProvider.notifier);
    final theme = Theme.of(context);
    final isDark =
        themeState.themeMode == ThemeMode.dark ||
        (themeState.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    final seedColor = themeState.seedColor ?? Colors.deepPurple;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusL),
      child: Column(
        children: [
          // 1. Notifications
          ListTile(
            leading: Icon(
              Icons.notifications_none_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            title: Text(LocaleKeys.settings_notifications.tr()),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),

          // 2. Language
          ListTile(
            leading: Icon(
              Icons.language_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            title: Text(LocaleKeys.settings_language.tr()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.locale.languageCode == 'fa'
                      ? LocaleKeys.language_fa.tr()
                      : LocaleKeys.language_en.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ],
            ),
            onTap: () {
              if (context.locale.languageCode == 'fa') {
                context.setLocale(const Locale('en', 'US'));
              } else {
                context.setLocale(const Locale('fa'));
              }
            },
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),

          // 3. Theme Color
          ListTile(
            leading: Icon(
              Icons.palette_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            title: Text(LocaleKeys.settings_theme.tr()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.xs,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: seedColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ],
            ),
            onTap: () => context.push(AppRoutes.themeColor),
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),

          // 4. Dark Mode
          SwitchListTile(
            secondary: Icon(
              Icons.dark_mode_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            title: Text(LocaleKeys.settings_dark_mode.tr()),
            value: isDark,
            onChanged: (value) => themeNotifier.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
