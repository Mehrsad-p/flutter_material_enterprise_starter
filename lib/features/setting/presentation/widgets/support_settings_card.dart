import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

class SupportSettingsCard extends StatelessWidget {
  const SupportSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              Icons.info_outline_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            title: Text(LocaleKeys.settings_about.tr()),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          ListTile(
            leading: Icon(
              Icons.chat_bubble_outline_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            title: Text(LocaleKeys.settings_help.tr()),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56, endIndent: 16),
          ListTile(
            leading: Icon(
              Icons.delete_outline_rounded,
              color: theme.colorScheme.error,
            ),
            title: Text(
              LocaleKeys.settings_deactivate.tr(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.error,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
