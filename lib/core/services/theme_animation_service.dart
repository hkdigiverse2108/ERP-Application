import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Drives a circular-reveal (ripple) animation when the user switches themes.
///
/// HOW IT WORKS
/// ─────────────
/// 1. Capture the currently visible screen via a GlobalKey on a RepaintBoundary
///    placed in App.builder (always reflects the active route).
/// 2. Switch the theme — new theme renders underneath immediately.
/// 3. Insert an Overlay showing the OLD screenshot clipped to a shrinking
///    circle that collapses toward the toggle-button origin.
/// 4. Remove the overlay and dispose the image when the animation ends.
///
/// SETUP (app.dart)
/// ────────────────
/// builder: (context, child) {
///   return RepaintBoundary(
///     key: ThemeAnimationService.repaintKey,
///     child: child!,
///   );
/// }
///
/// No registerOverlayContext() call needed — we use Get.overlayContext instead.
class ThemeAnimationService {
  ThemeAnimationService._();

  /// Attach this key to the RepaintBoundary in App.builder.
  static final repaintKey = GlobalKey();

  static bool _isAnimating = false;

  /// Trigger the circular-reveal animation, then switch the theme.
  ///
  /// [originKey] – GlobalKey on the toggle button (defines ripple centre).
  /// [onSwitch]  – Callback that calls ThemeService().switchTheme().
  /// [duration]  – Total animation length. 1000 ms looks natural.
  static Future<void> animateThemeSwitch({
    required GlobalKey originKey,
    required VoidCallback onSwitch,
    Duration duration = const Duration(milliseconds: 1000),
  }) async {
    // Guard: prevent stacked animations on rapid taps.
    if (_isAnimating) {
      onSwitch();
      return;
    }

    final context = originKey.currentContext;
    if (context == null) {
      onSwitch();
      return;
    }

    // ── 1. Resolve the ripple origin in global coordinates ─────────────────
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      onSwitch();
      return;
    }
    final origin = renderBox.localToGlobal(renderBox.size.center(Offset.zero));

    // ── 2. Capture the current screen ─────────────────────────────────────
    final screenshot = await _captureCurrentScreen();
    if (screenshot == null) {
      onSwitch();
      return;
    }

    if (!context.mounted) {
      onSwitch();
      return;
    }

    // ── 3. Insert overlay (still showing old theme via screenshot) ─────────
    final overlayState = Overlay.of(context, rootOverlay: true);
    _isAnimating = true;
    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (_) => _CircularRevealWidget(
        image: screenshot,
        origin: origin,
        duration: duration,
        onSwitch: onSwitch,
        onComplete: () {
          entry?.remove();
          entry = null;
          _isAnimating = false;
          screenshot.dispose();
        },
      ),
    );

    overlayState.insert(entry!);
  }

  // ── Screenshot via explicit RepaintBoundary key ────────────────────────

  static Future<ui.Image?> _captureCurrentScreen() async {
    try {
      final context = repaintKey.currentContext;
      if (context == null) return null;
      final boundary = context.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final pixelRatio = View.of(context).devicePixelRatio;
      return await boundary.toImage(pixelRatio: pixelRatio);
    } catch (_) {
      return null;
    }
  }
}

// ── Overlay widget ───────────────────────────────────────────────────────

class _CircularRevealWidget extends StatefulWidget {
  final ui.Image image;
  final Offset origin;
  final Duration duration;
  final VoidCallback onSwitch;
  final VoidCallback onComplete;

  const _CircularRevealWidget({
    required this.image,
    required this.origin,
    required this.duration,
    required this.onSwitch,
    required this.onComplete,
  });

  @override
  State<_CircularRevealWidget> createState() => _CircularRevealWidgetState();
}

class _CircularRevealWidgetState extends State<_CircularRevealWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fraction;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    _fraction = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic));

    // Orchestration:
    // 1. The overlay renders its first frame (frozen old-theme screenshot).
    // 2. We then trigger the theme switch — a heavy rebuild of the whole tree.
    // 3. We wait one extra frame so that rebuild is fully painted underneath.
    // 4. Only then do we start the reveal animation — guaranteeing smooth frames.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.onSwitch();
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        _ctrl.forward().then((_) => widget.onComplete());
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _fraction,
      builder: (_, _) => CustomPaint(
        size: size,
        painter: _RevealPainter(
          image: widget.image,
          origin: widget.origin,
          fraction: _fraction.value,
        ),
      ),
    );
  }
}

// ── CustomPainter ─────────────────────────────────────────────────────────

class _RevealPainter extends CustomPainter {
  final ui.Image image;
  final Offset origin;
  final double fraction; // 1.0 = o

  static final _paint = Paint()
    ..filterQuality =
        ui.FilterQuality.medium; // ld screen visible, 0.0 = new theme revealed

  const _RevealPainter({
    required this.image,
    required this.origin,
    required this.fraction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (fraction <= 0) return;

    final maxR = _farthestCornerDistance(origin, size);
    final radius = maxR * fraction;

    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: origin, radius: radius)),
    );
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Offset.zero & size,
      _paint,
    );
    canvas.restore();
  }

  static double _farthestCornerDistance(Offset origin, Size size) {
    return [
      Offset.zero,
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ].fold(0.0, (max, c) {
      final d = (c - origin).distance;
      return d > max ? d : max;
    });
  }

  @override
  bool shouldRepaint(_RevealPainter old) => old.fraction != fraction;
}
