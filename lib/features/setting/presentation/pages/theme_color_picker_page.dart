import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/theme/theme_color_card.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/theme/font_size_toggle_card.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/theme/theme_preset_swatches_card.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Full-screen body content for the Theme Color Picker sub-route.
/// Rendered inside the Settings shell Scaffold (no Scaffold of its own).
///
/// State is kept here as a single [HSVColor] and pushed to
/// [appThemeNotifierProvider] on every change so the live preview
/// propagates through the entire app instantly.
class ThemeColorPickerBody extends ConsumerStatefulWidget {
  const ThemeColorPickerBody({super.key});

  @override
  ConsumerState<ThemeColorPickerBody> createState() =>
      _ThemeColorPickerBodyState();
}

class _ThemeColorPickerBodyState extends ConsumerState<ThemeColorPickerBody> {
  late HSVColor _hsv;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final initialColor =
          ref.read(appThemeNotifierProvider).seedColor ?? Colors.deepPurple;
      _hsv = HSVColor.fromColor(initialColor);
      _initialized = true;
    }
  }

  Color get _currentColor => _hsv.toColor();

  void _onHueChanged(double hue) {
    setState(() => _hsv = _hsv.withHue(hue));
    ref.read(appThemeNotifierProvider.notifier).setSeedColor(_currentColor);
  }

  void _onValueChanged(double val) {
    setState(() => _hsv = _hsv.withValue(val));
    ref.read(appThemeNotifierProvider.notifier).setSeedColor(_currentColor);
  }

  void _onPresetSelected(Color color) {
    setState(() => _hsv = HSVColor.fromColor(color));
    ref.read(appThemeNotifierProvider.notifier).setSeedColor(color);
  }

  Color _contrastOn(Color bg) =>
      bg.computeLuminance() > 0.4 ? Colors.black87 : Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: AppSpacing.paddingAllL,
        child: Column(
          spacing: AppSpacing.spacingMin,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── 1. Gradient header showing current color ──────────
            // ThemePreviewHeader(color: _currentColor),

            // ── 2. Color Wheel + Brightness slider ────────────────
            ThemeColorCard(
              hsvColor: _hsv,
              onHueChanged: _onHueChanged,
              onValueChanged: _onValueChanged,
            ),

            // ── 3. Preset swatches ────────────────────────────────
            ThemePresetSwatchesCard(
              selectedColor: _currentColor,
              onSelected: _onPresetSelected,
            ),

            // ── 4. Font Size Settings ─────────────────────────────
            const FontSizeToggleCard(),

            // ── 5. Confirm button ─────────────────────────────────
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _currentColor,
                foregroundColor: _contrastOn(_currentColor),
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.borderRadiusL,
                ),
              ),
              icon: const Icon(Icons.check_rounded),
              label: Text(
                LocaleKeys.settings_color_picker_apply.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
