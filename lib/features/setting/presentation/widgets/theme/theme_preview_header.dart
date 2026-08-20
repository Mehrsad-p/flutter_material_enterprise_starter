import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/color_extensions.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

/// A prominent Card showing the currently selected seed color, its HEX code,
/// and an accessible contrast-aware label. Used as the header of the
/// ThemeColorPickerBody page.
class ThemePreviewHeader extends StatelessWidget {
  const ThemePreviewHeader({super.key, required this.color});

  final Color color;

  /// Returns white or black text color based on the background luminance
  /// for WCAG-compliant contrast.
  Color _contrastOn(Color bg) =>
      bg.computeLuminance() > 0.4 ? Colors.black87 : Colors.white;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hex = color.toHex();
    final onColor = _contrastOn(color);

    return Card(
      elevation: 2,
      shadowColor: color.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusL),
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              HSVColor.fromColor(color).withValue(
                (HSVColor.fromColor(color).value * 0.75).clamp(0, 1),
              ).toColor(),
            ],
          ),
        ),
        padding: AppSpacing.paddingAllL,
        child: Row(
          spacing: AppSpacing.spacingMin,
          children: [
            // Glowing color circle
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: onColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: onColor.withValues(alpha: 0.35),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.palette_rounded,
                color: onColor,
                size: 26,
              ),
            ),

            // Label + HEX
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xs,
                children: [
                  Text(
                    LocaleKeys.settings_color_picker_title.tr(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: onColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    hex,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: onColor.withValues(alpha: 0.8),
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // Hex badge chip
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: onColor.withValues(alpha: 0.15),
                borderRadius: AppRadius.borderRadiusM,
                border: Border.all(
                  color: onColor.withValues(alpha: 0.25),
                ),
              ),
              child: Text(
                hex,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: onColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
