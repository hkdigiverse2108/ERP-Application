import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';

class SectionShimmer extends StatefulWidget {
  final double height;
  final double? padding;
  const SectionShimmer({super.key, this.height = 200, this.padding = 0});

  @override
  State<SectionShimmer> createState() => _SectionShimmerState();
}

class _SectionShimmerState extends State<SectionShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService().isDarkMode;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: EdgeInsets.all(widget.padding ?? 0),
      child: BorderContainer(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: widget.height,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                gradient: LinearGradient(
                  begin: Alignment(_animation.value - 1, -0.3),
                  end: Alignment(_animation.value + 1, 0.3),
                  colors: [baseColor, highlightColor, baseColor],
                  stops: const [0.1, 0.5, 0.9],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
