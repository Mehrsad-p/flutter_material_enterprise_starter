import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Body content for the Theme Color Picker screen.
/// Rendered inside the Settings shell Scaffold — no Scaffold of its own.
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
          ref.watch(appThemeNotifierProvider).seedColor ?? Colors.deepPurple;
      _hsv = HSVColor.fromColor(initialColor);
      _initialized = true;
    }
  }

  Color get _currentColor => _hsv.toColor();

  void _onWheelHueChanged(double hue) {
    setState(() => _hsv = _hsv.withHue(hue));
    ref.read(appThemeNotifierProvider.notifier).setSeedColor(_currentColor);
  }

  void _onValueChanged(double val) {
    setState(() => _hsv = _hsv.withValue(val));
    ref.read(appThemeNotifierProvider.notifier).setSeedColor(_currentColor);
  }

  Color _contrastColor(Color bg) {
    return bg.computeLuminance() > 0.4 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surfaceContainerLow;
    final hex =
        '#${_currentColor.toARGB32().toRadixString(16).toUpperCase().substring(2)}';

    return SafeArea(
      child: SingleChildScrollView(
        padding: AppSpacing.paddingAllL,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.spacingMax,
          children: [
            // ── Current color preview card ──────────────────────
            Card(
              elevation: 0,
              color: surfaceColor,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderRadiusL,
              ),
              child: Padding(
                padding: AppSpacing.paddingAllL,
                child: Row(
                  spacing: AppSpacing.spacingMin,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _currentColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _currentColor.withValues(alpha: 0.5),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpacing.xs,
                        children: [
                          Text(
                            'settings_theme'.tr(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            hex,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _currentColor,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Color wheel ─────────────────────────────────────
            Center(
              child: _ColorWheel(
                hsvColor: _hsv,
                onHueChanged: _onWheelHueChanged,
              ),
            ),

            // ── Brightness slider ────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: _BrightnessSlider(
                value: _hsv.value,
                hsvColor: _hsv,
                onChanged: _onValueChanged,
              ),
            ),

            // ── Preset swatches ──────────────────────────────────
            _PresetSwatches(
              selected: _currentColor,
              onSelected: (c) {
                setState(() => _hsv = HSVColor.fromColor(c));
                ref
                    .read(appThemeNotifierProvider.notifier)
                    .setSeedColor(c);
              },
            ),

            // ── Confirm button ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: _currentColor,
                  foregroundColor: _contrastColor(_currentColor),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.borderRadiusL,
                  ),
                ),
                icon: const Icon(Icons.check_rounded),
                label: const Text(
                  'تایید و ذخیره',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Color Wheel
// ─────────────────────────────────────────────────────────────
class _ColorWheel extends StatefulWidget {
  const _ColorWheel({required this.hsvColor, required this.onHueChanged});
  final HSVColor hsvColor;
  final ValueChanged<double> onHueChanged;

  @override
  State<_ColorWheel> createState() => _ColorWheelState();
}

class _ColorWheelState extends State<_ColorWheel> {
  static const double _size = 240;
  static const double _ringWidth = 32;

  double get _outerRadius => _size / 2;
  double get _innerRadius => _outerRadius - _ringWidth;
  double get _midRadius => (_outerRadius + _innerRadius) / 2;
  Offset get _center => const Offset(_size / 2, _size / 2);

  Offset get _thumbOffset {
    final angle = widget.hsvColor.hue * math.pi / 180.0;
    return Offset(
      _center.dx + _midRadius * math.cos(angle),
      _center.dy + _midRadius * math.sin(angle),
    );
  }

  bool _isOnRing(Offset pos) {
    final d = (pos - _center).distance;
    return d >= _innerRadius - 12 && d <= _outerRadius + 12;
  }

  void _handlePan(Offset localPos) {
    final delta = localPos - _center;
    final angle = math.atan2(delta.dy, delta.dx);
    double hue = angle * 180.0 / math.pi;
    if (hue < 0) hue += 360;
    widget.onHueChanged(hue);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: _size,
      height: _size,
      child: GestureDetector(
        onPanStart: (d) {
          if (_isOnRing(d.localPosition)) _handlePan(d.localPosition);
        },
        onPanUpdate: (d) => _handlePan(d.localPosition),
        child: CustomPaint(
          painter: _WheelPainter(
            hsvColor: widget.hsvColor,
            outerRadius: _outerRadius,
            innerRadius: _innerRadius,
            thumbOffset: _thumbOffset,
            isDark: isDark,
          ),
          size: const Size(_size, _size),
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter({
    required this.hsvColor,
    required this.outerRadius,
    required this.innerRadius,
    required this.thumbOffset,
    required this.isDark,
  });

  final HSVColor hsvColor;
  final double outerRadius;
  final double innerRadius;
  final Offset thumbOffset;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const steps = 360;
    final midRadius = (outerRadius + innerRadius) / 2;
    final ringThickness = outerRadius - innerRadius;

    for (int i = 0; i < steps; i++) {
      final startAngle = (i * 2 * math.pi) / steps;
      final sweepAngle = (2 * math.pi) / steps + 0.01;
      final paint = Paint()
        ..color = HSVColor.fromAHSV(1, i.toDouble(), 1, 1).toColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringThickness + 1;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: midRadius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    canvas.drawCircle(center, innerRadius - 2, Paint()..color = hsvColor.toColor());
    canvas.drawCircle(
      center,
      innerRadius,
      Paint()
        ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    const double thumbR = 12;
    canvas.drawCircle(
      thumbOffset, thumbR + 3,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(thumbOffset, thumbR, Paint()..color = Colors.white);
    canvas.drawCircle(
      thumbOffset, thumbR - 4,
      Paint()..color = HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor(),
    );
  }

  @override
  bool shouldRepaint(_WheelPainter old) =>
      old.hsvColor != hsvColor ||
      old.thumbOffset != thumbOffset ||
      old.isDark != isDark;
}

// ─────────────────────────────────────────────────────────────
//  Brightness slider
// ─────────────────────────────────────────────────────────────
class _BrightnessSlider extends StatelessWidget {
  const _BrightnessSlider({
    required this.value,
    required this.hsvColor,
    required this.onChanged,
  });
  final double value;
  final HSVColor hsvColor;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final baseColor = hsvColor.withSaturation(1).withValue(1).toColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Row(
          spacing: AppSpacing.xs,
          children: [
            Icon(
              Icons.light_mode_rounded,
              size: 18,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
            Text(
              'روشنایی',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
          ],
        ),
        Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(colors: [Colors.black, baseColor]),
            boxShadow: [
              BoxShadow(
                color: baseColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 36,
              thumbShape: _GlowThumbShape(color: hsvColor.toColor()),
              trackShape: const _TransparentTrackShape(),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.transparent,
              inactiveColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}

class _TransparentTrackShape extends RoundedRectSliderTrackShape {
  const _TransparentTrackShape();
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {}
}

class _GlowThumbShape extends SliderComponentShape {
  const _GlowThumbShape({required this.color});
  final Color color;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(28, 28);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center, 17,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawCircle(center, 14, Paint()..color = Colors.white);
    canvas.drawCircle(center, 10, Paint()..color = color);
  }
}

// ─────────────────────────────────────────────────────────────
//  Preset swatches
// ─────────────────────────────────────────────────────────────
class _PresetSwatches extends StatelessWidget {
  const _PresetSwatches({required this.selected, required this.onSelected});
  final Color selected;
  final ValueChanged<Color> onSelected;

  static const List<Color> _presets = [
    Color(0xFF6750A4),
    Color(0xFF0061A4),
    Color(0xFF006E1C),
    Color(0xFFB3261E),
    Color(0xFF7D5260),
    Color(0xFF006A6A),
    Color(0xFFFF6B35),
    Color(0xFF1A1A2E),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _presets.map((c) {
          final isSelected =
              (c.toARGB32() & 0xFFFFFF) == (selected.toARGB32() & 0xFFFFFF);
          return GestureDetector(
            onTap: () => onSelected(c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: isSelected ? 36 : 30,
              height: isSelected ? 36 : 30,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [BoxShadow(color: c.withValues(alpha: 0.6), blurRadius: 10, spreadRadius: 2)]
                    : [],
                border: isSelected ? Border.all(color: Colors.white, width: 2.5) : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
