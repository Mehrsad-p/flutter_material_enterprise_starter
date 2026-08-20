import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_radius.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/tokens/app_spacing.dart';
import 'package:flutter_material_enterprise_starter/generated/locale_keys.g.dart';

/// A Card containing the interactive Color Wheel and the Brightness slider.
/// Accepts HSVColor callbacks so the parent page owns the state.
class ThemeColorCard extends StatelessWidget {
  const ThemeColorCard({
    super.key,
    required this.hsvColor,
    required this.onHueChanged,
    required this.onValueChanged,
  });

  final HSVColor hsvColor;
  final ValueChanged<double> onHueChanged;
  final ValueChanged<double> onValueChanged;

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
          spacing: AppSpacing.spacingMax,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section label
            Row(
              spacing: AppSpacing.xs,
              children: [
                Icon(
                  Icons.colorize_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                Text(
                  LocaleKeys.settings_color_picker_color_wheel.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),

            // Color Wheel
            Center(
              child: _ColorWheel(
                hsvColor: hsvColor,
                onHueChanged: onHueChanged,
              ),
            ),

            // Brightness slider
            _BrightnessSlider(
              value: hsvColor.value,
              hsvColor: hsvColor,
              onChanged: onValueChanged,
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

    // Inner filled circle — preview of current color
    canvas.drawCircle(
      center,
      innerRadius - 2,
      Paint()..color = hsvColor.toColor(),
    );

    // Subtle ring border
    canvas.drawCircle(
      center,
      innerRadius,
      Paint()
        ..color =
            (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Thumb
    const double thumbR = 12;
    canvas.drawCircle(
      thumbOffset,
      thumbR + 3,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(thumbOffset, thumbR, Paint()..color = Colors.white);
    canvas.drawCircle(
      thumbOffset,
      thumbR - 4,
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
    final theme = Theme.of(context);

    return Column(
      spacing: AppSpacing.s,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.xs,
          children: [
            Icon(
              Icons.light_mode_rounded,
              size: 18,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            Text(
              LocaleKeys.settings_color_picker_brightness.tr(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadiusCircular,
            gradient: LinearGradient(
              // RTL-aware: slider thumb moves right→left at value=1
              colors: Directionality.of(context) == TextDirection.rtl
                  ? [baseColor, Colors.black]
                  : [Colors.black, baseColor],
            ),
            boxShadow: [
              BoxShadow(
                color: baseColor.withValues(alpha: 0.3),
                blurRadius: AppSpacing.s,
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
      center,
      17,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawCircle(center, 14, Paint()..color = Colors.white);
    canvas.drawCircle(center, 10, Paint()..color = color);
  }
}
