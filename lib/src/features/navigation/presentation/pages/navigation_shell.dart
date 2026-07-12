import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/theme/app_theme.dart';

// ─── Shell ────────────────────────────────────────────────────────────────────

class NavigationShell extends StatelessWidget {
  final Widget child;
  const NavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    const items = <_NavItem>[
      _NavItem(icon: Icons.home_rounded,          label: 'Home'),
      _NavItem(icon: Icons.favorite_rounded,       label: 'Favourites'),
      _NavItem(icon: Icons.library_books_rounded,  label: 'Courses'),
      _NavItem(icon: Icons.person_rounded,         label: 'Profile'),
    ];

    final tabPaths = ['/home', '/favourites', '/courses', '/profile'];

    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    int activeIndex = 0;
    if (location.startsWith('/favourites')) {
      activeIndex = 1;
    } else if (location.startsWith('/courses')) {
      activeIndex = 2;
    } else if (location.startsWith('/profile')) {
      activeIndex = 3;
    }

    return Scaffold(
      backgroundColor: isLight ? AppColors.bgLight : AppColors.bgDark,
      extendBody: true,
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        backgroundColor: theme.colorScheme.primary,
        child: Icon(
          isLight ? Icons.brightness_3 : Icons.sunny,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _LiquidGlassNavBar(
        items: items,
        activeIndex: activeIndex,
        primaryColor: theme.colorScheme.primary,
        secondaryColor: theme.colorScheme.secondary,
        isLight: isLight,
        onTap: (i) => context.go(tabPaths[i]),
      ),
    );
  }
}

// ─── Data ─────────────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String   label;
  const _NavItem({required this.icon, required this.label});
}

// ─── Nav Bar ──────────────────────────────────────────────────────────────────

class _LiquidGlassNavBar extends StatefulWidget {
  final List<_NavItem>    items;
  final int               activeIndex;
  final Color             primaryColor;
  final Color             secondaryColor;
  final bool              isLight;
  final ValueChanged<int> onTap;

  const _LiquidGlassNavBar({
    required this.items,
    required this.activeIndex,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isLight,
    required this.onTap,
  });

  @override
  State<_LiquidGlassNavBar> createState() => _LiquidGlassNavBarState();
}

class _LiquidGlassNavBarState extends State<_LiquidGlassNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _blobCtrl;
  late Animation<double>   _blobAnim;
  int _prevIndex = 0;

  @override
  void initState() {
    super.initState();
    _prevIndex = widget.activeIndex;
    _blobCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _blobAnim = CurvedAnimation(
      parent: _blobCtrl,
      curve: Curves.easeInOutCubic,
    );
    _blobCtrl.value = 1.0; // start settled
  }

  @override
  void didUpdateWidget(_LiquidGlassNavBar old) {
    super.didUpdateWidget(old);
    if (old.activeIndex != widget.activeIndex) {
      _prevIndex = old.activeIndex;
      _blobCtrl.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _blobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.items.length;

    // Glass tray colours
    final trayBg = widget.isLight
        ? Colors.white.withValues(alpha: 0.18)
        : Colors.black.withValues(alpha: 0.28);
    final trayBorder = widget.isLight
        ? Colors.white.withValues(alpha: 0.45)
        : Colors.white.withValues(alpha: 0.18);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 28),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
          child: Container(
            decoration: BoxDecoration(
              color: trayBg,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: trayBorder, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.06),
                  blurRadius: 2,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: SizedBox(
              height: 76,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalW = constraints.maxWidth;
                  final cellW  = totalW / count;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // ── Animated liquid blob ──────────────────────────────
                      AnimatedBuilder(
                        animation: _blobAnim,
                        builder: (_, __) {
                          final fromX = _prevIndex * cellW;
                          final toX   = widget.activeIndex * cellW;
                          final cx    = lerpDouble(fromX, toX, _blobAnim.value)!;

                          return Positioned(
                            left: cx + cellW * 0.08,
                            top: 8,
                            child: _LiquidBlob(
                              width: cellW * 0.84,
                              height: 60,
                              progress: _blobAnim.value,
                              primaryColor: widget.primaryColor,
                              secondaryColor: widget.secondaryColor,
                            ),
                          );
                        },
                      ),

                      // ── Tab items ─────────────────────────────────────────
                      Row(
                        children: List.generate(count, (i) {
                          final isActive = i == widget.activeIndex;
                          final item     = widget.items[i];
                          return Expanded(
                            child: _GlassNavItem(
                              item:        item,
                              isActive:    isActive,
                              onTap: () {
                                HapticFeedback.lightImpact();
                                widget.onTap(i);
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Liquid Blob ──────────────────────────────────────────────────────────────

class _LiquidBlob extends StatelessWidget {
  final double width;
  final double height;
  final double progress;      // 0→1 during slide animation
  final Color  primaryColor;
  final Color  secondaryColor;

  const _LiquidBlob({
    required this.width,
    required this.height,
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _BlobPainter(
        progress:       progress,
        primaryColor:   primaryColor,
        secondaryColor: secondaryColor,
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  final double progress;
  final Color  primaryColor;
  final Color  secondaryColor;

  const _BlobPainter({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Squish factor: blob stretches wide mid-travel, snaps back at destination
    // progress==0 → just left destination; 0.5 → mid-travel; 1 → settled
    final squish = Curves.easeInOut.transform(
      (progress < 0.5)
          ? progress * 2         // 0→1 while travelling
          : (1 - progress) * 2,  // 1→0 while arriving
    );

    final xScale = 1.0 + squish * 0.18;   // max 18 % wider at mid-travel
    final yScale = 1.0 - squish * 0.10;   // max 10 % shorter at mid-travel

    final cx = w / 2;
    final cy = h / 2;
    final rw  = (w / 2) * xScale;
    final rh  = (h / 2) * yScale;

    // Organic blob: rounded rect with slight asymmetric control points
    final path = Path();
    const k = 0.55; // cubic bezier approximation constant for circles

    // Top-left corner slightly more organic
    path.moveTo(cx, cy - rh);

    path.cubicTo(
      cx + rw * k,  cy - rh,
      cx + rw,      cy - rh * k,
      cx + rw,      cy,
    );
    path.cubicTo(
      cx + rw,      cy + rh * (k + squish * 0.15),
      cx + rw * k,  cy + rh,
      cx,           cy + rh,
    );
    path.cubicTo(
      cx - rw * k,  cy + rh,
      cx - rw,      cy + rh * (k + squish * 0.15),
      cx - rw,      cy,
    );
    path.cubicTo(
      cx - rw,      cy - rh * k,
      cx - rw * k,  cy - rh,
      cx,           cy - rh,
    );
    path.close();

    // Gradient fill
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.4),
        radius: 1.1,
        colors: [
          secondaryColor.withValues(alpha: 0.95),
          primaryColor.withValues(alpha: 1.0),
          primaryColor.withValues(alpha: 0.85),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCenter(
        center: Offset(cx, cy),
        width: rw * 2,
        height: rh * 2,
      ))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Specular highlight — top-left gloss
    final glossPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.5, -0.6),
        radius: 0.6,
        colors: [
          Colors.white.withValues(alpha: 0.30),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCenter(
        center: Offset(cx, cy),
        width: rw * 2,
        height: rh * 2,
      ))
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, glossPaint);
  }

  @override
  bool shouldRepaint(_BlobPainter old) =>
      old.progress != progress ||
      old.primaryColor != primaryColor ||
      old.secondaryColor != secondaryColor;
}

// ─── Individual nav item ──────────────────────────────────────────────────────

class _GlassNavItem extends StatefulWidget {
  final _NavItem   item;
  final bool       isActive;
  final VoidCallback onTap;

  const _GlassNavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_GlassNavItem> createState() => _GlassNavItemState();
}

class _GlassNavItemState extends State<_GlassNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double>   _pressAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _pressAnim = Tween<double>(begin: 1.0, end: 0.88)
        .animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: widget.isActive,
      label: widget.item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _pressCtrl.forward(),
        onTapUp: (_) {
          _pressCtrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _pressCtrl.reverse(),
        child: ScaleTransition(
          scale: _pressAnim,
          child: SizedBox(
            height: 76,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: widget.isActive ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    widget.item.icon,
                    size: 24,
                    color: Colors.white.withValues(
                      alpha: widget.isActive ? 1.0 : 0.55,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: widget.isActive ? 11 : 10,
                    fontWeight: widget.isActive
                        ? FontWeight.w700
                        : FontWeight.w400,
                    color: Colors.white.withValues(
                      alpha: widget.isActive ? 1.0 : 0.55,
                    ),
                    letterSpacing: widget.isActive ? 0.2 : 0,
                  ),
                  child: Text(widget.item.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
