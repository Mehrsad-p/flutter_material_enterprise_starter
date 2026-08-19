import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─────────────────────────────────────────────────────────────
//  Public entry-point: a button that opens the BottomSheet
// ─────────────────────────────────────────────────────────────
class ColorPickerWidget extends ConsumerWidget {
  const ColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor =
        ref.watch(appThemeNotifierProvider).seedColor ?? Colors.deepPurple;

    return GestureDetector(
      onTap: () => _openColorSheet(context, ref, seedColor),
      child: _ColorPreviewButton(color: seedColor),
    );
  }

  void _openColorSheet(BuildContext context, WidgetRef ref, Color initial) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ColorPickerSheet(
        initialColor: initial,
        onColorChanged: (c) =>
            ref.read(appThemeNotifierProvider.notifier).setSeedColor(c),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Preview button (the trigger)
// ─────────────────────────────────────────────────────────────
class _ColorPreviewButton extends StatelessWidget {
  const _ColorPreviewButton({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رنگ اصلی برنامه',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '#${color.toARGB32().toRadixString(16).toUpperCase().substring(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.palette_rounded,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.chevron_right_rounded,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  BottomSheet
// ─────────────────────────────────────────────────────────────
class _ColorPickerSheet extends StatefulWidget {
  const _ColorPickerSheet({
    required this.initialColor,
    required this.onColorChanged,
  });
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<_ColorPickerSheet> createState() => _ColorPickerSheetState();
}

class _ColorPickerSheetState extends State<_ColorPickerSheet>
    with SingleTickerProviderStateMixin {
  late HSVColor _hsv;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _hsv = HSVColor.fromColor(widget.initialColor);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Color get _currentColor => _hsv.toColor();

  void _onWheelHueChanged(double hue) {
    setState(() => _hsv = _hsv.withHue(hue));
    widget.onColorChanged(_currentColor);
  }

  void _onValueChanged(double val) {
    setState(() => _hsv = _hsv.withValue(val));
    widget.onColorChanged(_currentColor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final surface =
        isDark ? const Color(0xFF252538) : const Color(0xFFF4F4F8);

    return ScaleTransition(
      scale: _scaleAnim,
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _currentColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _currentColor.withValues(alpha: 0.6),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'انتخاب رنگ',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  _HexBadge(color: _currentColor, surface: surface),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Color Wheel
            Center(
              child: _ColorWheel(
                hsvColor: _hsv,
                onHueChanged: _onWheelHueChanged,
              ),
            ),

            const SizedBox(height: 28),

            // Brightness slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _BrightnessSlider(
                value: _hsv.value,
                hsvColor: _hsv,
                onChanged: _onValueChanged,
              ),
            ),

            const SizedBox(height: 24),

            // Preset swatches
            _PresetSwatches(
              selected: _currentColor,
              onSelected: (c) {
                setState(() => _hsv = HSVColor.fromColor(c));
                widget.onColorChanged(c);
              },
            ),

            const SizedBox(height: 20),

            // Apply button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: _currentColor,
                  foregroundColor: _contrastColor(_currentColor),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.check_rounded),
                label: const Text(
                  'اعمال رنگ',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _contrastColor(Color bg) {
    final lum = bg.computeLuminance();
    return lum > 0.4 ? Colors.black : Colors.white;
  }
}

// ─────────────────────────────────────────────────────────────
//  Color Wheel (custom painter - ring only)
// ─────────────────────────────────────────────────────────────
class _ColorWheel extends StatefulWidget {
  const _ColorWheel({
    required this.hsvColor,
    required this.onHueChanged,
  });
  final HSVColor hsvColor;
  final ValueChanged<double> onHueChanged;

  @override
  State<_ColorWheel> createState() => _ColorWheelState();
}

class _ColorWheelState extends State<_ColorWheel> {
  static const double _size = 260;
  static const double _ringWidth = 36;

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

    // Hue ring
    for (int i = 0; i < steps; i++) {
      final startAngle = (i * 2 * math.pi) / steps;
      final sweepAngle = (2 * math.pi) / steps + 0.01;
      final hue = i.toDouble();

      final paint = Paint()
        ..color = HSVColor.fromAHSV(1, hue, 1, 1).toColor()
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

    // Inner circle preview
    canvas.drawCircle(
      center,
      innerRadius - 2,
      Paint()..color = hsvColor.toColor(),
    );

    // Subtle border
    canvas.drawCircle(
      center,
      innerRadius,
      Paint()
        ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Thumb shadow
    const double thumbR = 13;
    canvas.drawCircle(
      thumbOffset,
      thumbR + 3,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    // Thumb white outer
    canvas.drawCircle(
      thumbOffset,
      thumbR,
      Paint()..color = Colors.white,
    );
    // Thumb color fill
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.light_mode_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 6),
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
        const SizedBox(height: 10),
        Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [Colors.black, baseColor],
            ),
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
  }) {
    // Transparent - gradient is on the Container
  }
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
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
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

// ─────────────────────────────────────────────────────────────
//  Preset color swatches
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    ? [
                        BoxShadow(
                          color: c.withValues(alpha: 0.6),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
                border: isSelected
                    ? Border.all(color: Colors.white, width: 2.5)
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  HEX Badge
// ─────────────────────────────────────────────────────────────
class _HexBadge extends StatelessWidget {
  const _HexBadge({required this.color, required this.surface});
  final Color color;
  final Color surface;

  @override
  Widget build(BuildContext context) {
    final hex =
        '#${color.toARGB32().toRadixString(16).toUpperCase().substring(2)}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        hex,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
