import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class GlassBackground extends StatelessWidget {
  final Widget child;
  final double blur;

  const GlassBackground({
    super.key,
    required this.child,
    this.blur = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: glassBackgroundGradient(isLight),
            ),
          ),
        ),
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                color: isLight
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class GlassScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;

  const GlassScaffold({
    super.key,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: backgroundColor ??
          (isLight ? AppColors.bgLight : AppColors.bgDark),
      appBar: appBar,
      body: GlassBackground(child: body ?? const SizedBox.shrink()),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}