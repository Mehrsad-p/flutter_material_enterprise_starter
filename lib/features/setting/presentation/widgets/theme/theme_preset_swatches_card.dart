import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

/// A Card presenting a set of curated preset seed colors as selectable swatches.
class ThemePresetSwatchesCard extends StatelessWidget {
  const ThemePresetSwatchesCard({
    super.key,
    required this.selectedColor,
    required this.onSelected,
  });

  final Color selectedColor;
  final ValueChanged<Color> onSelected;

  static const List<Color> _presets = [
    Color(0xFF6750A4), // Material Purple
    Color(0xFF0061A4), // Deep Blue
    Color(0xFF006E1C), // Forest Green
    Color(0xFFB3261E), // Warm Red
    Color(0xFF7D5260), // Mauve
    Color(0xFF006A6A), // Teal
    Color(0xFFFF6B35), // Vivid Orange
    Color(0xFF1A1A2E), // Midnight
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  Icons.grid_view_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                Text(
                  LocaleKeys.settings_color_picker_presets.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),

            // Swatches row
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  spacing: AppSpacing.s,
                  children: [
                    ..._presets.map((c) {
                      final isSelected =
                          (c.toARGB32() & 0xFFFFFF) ==
                          (selectedColor.toARGB32() & 0xFFFFFF);

                      return GestureDetector(
                        onTap: () => onSelected(c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutCubic,
                          width: isSelected ? 38 : 30,
                          height: isSelected ? 38 : 30,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? theme.colorScheme.onSurface.withValues(
                                        alpha: 0.3,
                                      )
                                    : theme.colorScheme.tertiary.withValues(
                                        alpha: 0.15,
                                      ),
                                blurRadius: isSelected ? 10.0 : 5.0,
                                spreadRadius: isSelected ? 1.5 : 0.0,
                              ),
                            ],
                            border: isSelected
                                ? Border.all(
                                    color: theme.colorScheme.onSurface,
                                    width: 2.5,
                                  )
                                : Border.all(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.25),
                                    width: 1,
                                  ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
