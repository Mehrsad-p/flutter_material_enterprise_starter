import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/state/theme_state.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FontSizeToggleCard extends ConsumerWidget {
  const FontSizeToggleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeState = ref.watch(appThemeNotifierProvider);
    final notifier = ref.read(appThemeNotifierProvider.notifier);

    final currentSize = themeState.fontSize;

    Widget buildButton({
      required FontSize size,
      required String label,
      required double fontSize,
    }) {
      final isSelected = currentSize == size;
      return Expanded(
        child: GestureDetector(
          onTap: () => notifier.setFontSize(size),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: AppSpacing.paddingVerticalM,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surface,
              borderRadius: AppRadius.borderRadiusM,
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusL),
      child: Padding(
        padding: AppSpacing.paddingAllL,
        child: Column(
          spacing: AppSpacing.spacingMin,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section label
            Row(
              spacing: AppSpacing.xs,
              children: [
                Icon(
                  Icons.format_size_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                Text(
                  LocaleKeys.settings_font_size.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),

            // Separate Toggle Buttons
            Row(
              spacing: AppSpacing.s,
              children: [
                buildButton(
                  size: FontSize.small,
                  label: LocaleKeys.settings_font_size_small.tr(),
                  fontSize: 12,
                ),
                buildButton(
                  size: FontSize.medium,
                  label: LocaleKeys.settings_font_size_medium.tr(),
                  fontSize: 14,
                ),
                buildButton(
                  size: FontSize.large,
                  label: LocaleKeys.settings_font_size_large.tr(),
                  fontSize: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
