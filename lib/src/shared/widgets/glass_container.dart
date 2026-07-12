import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

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

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur = 15,
    this.opacity = 0.15,
    this.borderOpacity,
    this.boxShadow,
    this.foregroundDecoration,
    this.clipBehavior = Clip.antiAlias,
    this.customBgColor,
    this.useGradientBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = customBgColor ??
        (isDark
            ? Colors.white.withOpacity(opacity.clamp(0.08, 0.18))
            : Colors.white.withOpacity(opacity.clamp(0.55, 0.8)));
    final borderColor = isDark
        ? Colors.white.withOpacity(borderOpacity ?? 0.12)
        : Colors.white.withOpacity(borderOpacity ?? 0.5);
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(16);
    final blurValue = blur.clamp(8.0, 30.0);

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
                          ? Colors.black.withOpacity(0.3)
                          : AppColors.primary.withOpacity(0.08),
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
