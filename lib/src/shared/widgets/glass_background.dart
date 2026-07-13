import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:codemap2/src/theme/app_theme.dart';

/// Premium Liquid Glass background with Apple-inspired gradient and blur.
class GlassBackground extends StatelessWidget {
  final Widget child;
  final double blur;
  final bool useLiquidGlass;

  const GlassBackground({
    super.key,
    required this.child,
    this.blur = 12,
    this.useLiquidGlass = true,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    Widget content = Stack(
      children: [
        // Gradient background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: glassBackgroundGradient(isLight),
            ),
          ),
        ),
        // Frosted blur overlay
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                color: isLight
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
        child,
      ],
    );

    if (useLiquidGlass) {
      content = LiquidGlassLayer(
        settings: LiquidGlassSettings(
          thickness: 8,
          blur: blur,
          glassColor: isLight
              ? const Color(0x08FFFFFF)
              : const Color(0x04000000),
          lightIntensity: 0.6,
          lightAngle: 2.4,
          ambientStrength: 0.08,
          saturation: 1.05,
          chromaticAberration: 0.002,
        ),
        child: content,
      );
    }

    return content;
  }
}

/// A Scaffold that uses GlassBackground for its body.
class GlassScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool extendBody;
  final Widget? bottomNavigationBar;
  final bool useLiquidGlass;

  const GlassScaffold({
    super.key,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.extendBody = false,
    this.bottomNavigationBar,
    this.useLiquidGlass = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ??
          Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      extendBody: extendBody,
      bottomNavigationBar: bottomNavigationBar,
      body: GlassBackground(
        useLiquidGlass: useLiquidGlass,
        child: body ?? const SizedBox.shrink(),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
