import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherSettingsCard extends ConsumerWidget {
  const OtherSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(appThemeNotifierProvider);
    final themeNotifier = ref.read(appThemeNotifierProvider.notifier);
    final theme = Theme.of(context);
    final isDark = themeState.themeMode == ThemeMode.dark || 
        (themeState.themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusL,
      ),
      child: Column(
        children: [
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
