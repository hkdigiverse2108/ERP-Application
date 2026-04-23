import 'package:ai_setu/core/services/theme_animation_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A plug-and-play theme toggle button with a circular-reveal animation.
///
/// Drop it anywhere — AppBar actions, Settings page, Drawer footer, etc.
///
/// ```dart
/// // In AppBar actions:
/// const ThemeToggleButton()
///
/// // Larger, labelled version for Settings:
/// ThemeToggleButton(size: 24, showLabel: true)
/// ```
class ThemeToggleButton extends StatelessWidget {
  final double size;
  final Color? lightIconColor;
  final Color? darkIconColor;
  final bool showLabel;

  final bool compact;

  ThemeToggleButton({
    super.key,
    this.size = 22,
    this.lightIconColor,
    this.darkIconColor,
    this.showLabel = false,
    this.compact = false,
  });

  // Each button instance gets its own key so the animation origin is precise.
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeService().isDarkModeObs.value;

      final icon = isDark ? PhosphorIconsLight.sun : PhosphorIconsLight.moon;

      final iconColor = isDark
          ? (darkIconColor ?? Colors.white)
          : (lightIconColor ?? Colors.white);

      final label = isDark ? 'Light mode' : 'Dark mode';

      if (showLabel) {
        // ── Labelled tile (for Settings / Drawer) ──────────────────────────
        return InkWell(
          key: _key,
          onTap: _toggle,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: size, color: context.appColors.textPrimary),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      }

      final animIcon = AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: Tween<double>(begin: 0.75, end: 1.0).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: Icon(icon, key: ValueKey(isDark), size: size, color: iconColor),
      );

      if (compact) {
        // ── Compact bare icon (for nesting inside custom rounded buttons) ──
        return GestureDetector(
          key: _key,
          onTap: _toggle,
          behavior: HitTestBehavior.opaque,
          child: Tooltip(message: label, child: animIcon),
        );
      }

      // ── Icon-only button (for AppBar) ─────────────────────────────────────
      return IconButton(
        key: _key,
        onPressed: _toggle,
        tooltip: label,
        padding: EdgeInsets.all(4),
        icon: animIcon,
      );
    });
  }

  void _toggle() {
    ThemeAnimationService.animateThemeSwitch(
      originKey: _key,
      onSwitch: ThemeService().switchTheme,
    );
  }
}
