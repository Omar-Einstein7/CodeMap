import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class NavigationShell extends StatelessWidget {
  final Widget child;

  const NavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    const items = <_NavItem>[
      _NavItem(icon: Icons.home_rounded, label: 'Home'),
      _NavItem(icon: Icons.favorite_rounded, label: 'Favourites'),
      _NavItem(icon: Icons.library_books_rounded, label: 'Courses'),
      _NavItem(icon: Icons.person_rounded, label: 'Profile'),
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
      bottomNavigationBar: _FloatingGlassNavBar(
        items: items,
        activeIndex: activeIndex,
        isLight: isLight,
        primaryColor: theme.colorScheme.primary,
        surfaceColor: theme.colorScheme.surface,
        onSurfaceColor: theme.colorScheme.onSurface,
        onTap: (index) => context.go(tabPaths[index]),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

class _FloatingGlassNavBar extends StatelessWidget {
  final List<_NavItem> items;
  final int activeIndex;
  final bool isLight;
  final Color primaryColor;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final ValueChanged<int> onTap;

  const _FloatingGlassNavBar({
    required this.items,
    required this.activeIndex,
    required this.isLight,
    required this.primaryColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: isLight
                  ? surfaceColor.withValues(alpha: 0.78)
                  : surfaceColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isLight
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.white.withValues(alpha: 0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: isLight
                      ? Colors.black.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.4),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: List.generate(items.length, (i) {
                final isActive = i == activeIndex;
                final item = items[i];
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isActive ? 4 : 6,
                      bottom: isActive ? 4 : 6,
                      left: 2,
                      right: 2,
                    ),
                    child: _NavBarItem(
                      item: item,
                      isActive: isActive,
                      isLight: isLight,
                      primaryColor: primaryColor,
                      onTap: () => onTap(i),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final bool isLight;
  final Color primaryColor;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.isLight,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _bounceAnim = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );
    if (widget.isActive) {
      _bounceController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_NavBarItem old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      _bounceController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inactiveIconColor = widget.isLight
        ? Colors.black38
        : Colors.white38;
    final inactiveLabelColor = widget.isLight
        ? Colors.black54
        : Colors.white54;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Semantics(
        button: true,
        selected: widget.isActive,
        label: widget.item.label,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onTap();
            },
            borderRadius: BorderRadius.circular(20),
            hoverColor: widget.primaryColor.withValues(alpha: 0.08),
            splashColor: widget.primaryColor.withValues(alpha: 0.15),
            highlightColor: Colors.transparent,
            child: AnimatedScale(
              scale: _isHovered && !widget.isActive ? 1.08 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: AnimatedBuilder(
                animation: _bounceAnim,
                builder: (context, child) {
                  final bounceScale = 1.0 +
                      (_bounceAnim.value * 0.06);
                  return Transform.scale(
                    scale: widget.isActive ? bounceScale : 1.0,
                    child: child,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: widget.isActive ? 48 : 28,
                      height: 32,
                      decoration: BoxDecoration(
                        color: widget.isActive
                            ? widget.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: widget.isActive
                            ? [
                                BoxShadow(
                                  color: widget.primaryColor
                                      .withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        widget.item.icon,
                        size: widget.isActive ? 22 : 24,
                        color: widget.isActive
                            ? Colors.white
                            : _isHovered
                                ? (widget.isLight
                                    ? Colors.black54
                                    : Colors.white70)
                                : inactiveIconColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      offset: widget.isActive
                          ? Offset.zero
                          : const Offset(0, 0.3),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: widget.isActive ? 1.0 : 0.0,
                        child: Text(
                          widget.item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: widget.isActive
                                ? widget.primaryColor
                                : inactiveLabelColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
