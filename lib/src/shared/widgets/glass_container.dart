import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:codemap2/src/theme/app_theme.dart';

/// A premium frosted glass container using Apple-inspired Liquid Glass rendering.
/// Supports light and dark modes with fine-tuned glass parameters.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double blur;
  final double opacity;
  final double? borderOpacity;
  final List<BoxShadow>? boxShadow;
  final Decoration? foregroundDecoration;
  final Clip clipBehavior;
  final Color? customBgColor;
  final bool useGradientBorder;
  final bool useLiquidGlass;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur = 20,
    this.opacity = 0.15,
    this.borderOpacity,
    this.boxShadow,
    this.foregroundDecoration,
    this.clipBehavior = Clip.antiAlias,
    this.customBgColor,
    this.useGradientBorder = false,
    this.useLiquidGlass = true,
  });

  LiquidGlassSettings _glassSettings(bool isDark) {
    return LiquidGlassSettings(
      thickness: 18,
      blur: blur.clamp(10, 30),
      glassColor: isDark
          ? const Color(0x18000000)
          : const Color(0x18FFFFFF),
      lightIntensity: 1.4,
      lightAngle: 2.4,
      ambientStrength: 0.12,
      saturation: 1.1,
      chromaticAberration: 0.004,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = customBgColor ??
        (isDark
            ? Colors.white.withValues(alpha: opacity.clamp(0.08, 0.18))
            : Colors.white.withValues(alpha: opacity.clamp(0.55, 0.8)));
    final borderColor = isDark
        ? Colors.white.withValues(alpha: borderOpacity ?? 0.12)
        : Colors.white.withValues(alpha: borderOpacity ?? 0.5);
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(20);
    final blurValue = blur.clamp(8.0, 30.0);

    if (useLiquidGlass) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        child: ClipRRect(
          borderRadius: effectiveBorderRadius,
          child: LiquidGlassLayer(
            settings: _glassSettings(isDark),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: effectiveBorderRadius,
                border: Border.all(color: borderColor),
                boxShadow: boxShadow ??
                    [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.25)
                            : AppColors.primary.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
              ),
              foregroundDecoration: foregroundDecoration,
              child: child,
            ),
          ),
        ),
      );
    }

    // Fallback to standard BackdropFilter approach
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: effectiveBorderRadius,
              border: Border.all(color: borderColor),
              boxShadow: boxShadow ??
                  [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.3)
                          : AppColors.primary.withValues(alpha: 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
            ),
            foregroundDecoration: foregroundDecoration,
            child: child,
          ),
        ),
      ),
    );
  }
}
