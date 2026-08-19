import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/profile_card_widget.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/other_settings_card.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/support_settings_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The default body content for the Settings shell.
/// Shown when the user is at the root /settings route.
class SettingsBody extends ConsumerWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: AppSpacing.paddingAllL,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.spacing,
          children: [
            const ProfileCardWidget(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.spacingMin,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  child: Text(
                    LocaleKeys.settings_other_section.tr(),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const OtherSettingsCard(),
              ],
            ),

            const SupportSettingsCard(),
          ],
        ),
      ),
    );
  }
}
