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
      bottomNavigationBar: _ClayNavBar(
        items: items,
        activeIndex: activeIndex,
        isLight: isLight,
        primaryColor: theme.colorScheme.primary,
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

class _ClayNavBar extends StatelessWidget {
  final List<_NavItem> items;
  final int activeIndex;
  final bool isLight;
  final Color primaryColor;
  final ValueChanged<int> onTap;

  const _ClayNavBar({
    required this.items,
    required this.activeIndex,
    required this.isLight,
    required this.primaryColor,
    required this.onTap,
  });

  Color get _trayColor => isLight
      ? const Color(0xFFEEF1F8)
      : const Color(0xFF1A1D28);

  Color get _trayBorder => isLight
      ? const Color(0xFFDCE0EC)
      : const Color(0xFF2A2D3A);

  List<BoxShadow> get _trayShadow => [
        BoxShadow(
          color: isLight
              ? Colors.white.withValues(alpha: 0.8)
              : const Color(0xFF2E3240).withValues(alpha: 0.6),
          blurRadius: 12,
          offset: const Offset(-4, -4),
        ),
        BoxShadow(
          color: isLight
              ? Colors.black.withValues(alpha: 0.10)
              : Colors.black.withValues(alpha: 0.45),
          blurRadius: 16,
          offset: const Offset(4, 6),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: _trayColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _trayBorder, width: 2),
          boxShadow: _trayShadow,
        ),
        child: Row(
          children: List.generate(items.length, (i) {
            final isActive = i == activeIndex;
            final item = items[i];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  i == 0 ? 6 : 3,
                  6,
                  i == items.length - 1 ? 6 : 3,
                  6,
                ),
                child: _ClayNavItem(
                  item: item,
                  isActive: isActive,
                  isLight: isLight,
                  primaryColor: primaryColor,
                  trayColor: _trayColor,
                  onTap: () => onTap(i),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _ClayNavItem extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final bool isLight;
  final Color primaryColor;
  final Color trayColor;
  final VoidCallback onTap;

  const _ClayNavItem({
    required this.item,
    required this.isActive,
    required this.isLight,
    required this.primaryColor,
    required this.trayColor,
    required this.onTap,
  });

  @override
  State<_ClayNavItem> createState() => _ClayNavItemState();
}

class _ClayNavItemState extends State<_ClayNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _popController;
  late Animation<double> _popAnim;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _popController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _popAnim = CurvedAnimation(
      parent: _popController,
      curve: Curves.elasticOut,
    );
    if (widget.isActive) {
      _popController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_ClayNavItem old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      _popController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    super.dispose();
  }

  Color get _clayBase {
    if (widget.isActive) return widget.primaryColor;
    return widget.trayColor;
  }

  Color get _borderColor {
    if (widget.isActive) return widget.primaryColor;
    return widget.isLight
        ? Colors.black.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.06);
  }

  double get _borderWidth => widget.isActive ? 3 : 1;

  List<BoxShadow> get _itemShadow {
    if (widget.isActive) {
      return [
        BoxShadow(
          color: widget.isLight
              ? Colors.white.withValues(alpha: 0.7)
              : const Color(0xFF2E3240).withValues(alpha: 0.5),
          blurRadius: 6,
          offset: const Offset(-2, -2),
        ),
        BoxShadow(
          color: widget.primaryColor.withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(3, 4),
        ),
      ];
    }
    return [
      BoxShadow(
        color: widget.isLight
            ? Colors.black.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.2),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ];
  }

  Color get _iconColor {
    if (widget.isActive) return Colors.white;
    return widget.isLight
        ? Colors.black38
        : Colors.white38;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: widget.isActive,
      label: widget.item.label,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        child: AnimatedScale(
          scale: _isPressed ? 0.93 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedBuilder(
            animation: _popAnim,
            builder: (context, child) {
              final popScale = 1.0 + (_popAnim.value * 0.05);
              return Transform.scale(
                scale: widget.isActive ? popScale : 1.0,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _clayBase,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _borderColor,
                  width: _borderWidth,
                ),
                boxShadow: _itemShadow,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Icon(
                      widget.item.icon,
                      key: ValueKey('${widget.isActive}_${widget.item.icon}'),
                      size: widget.isActive ? 22 : 24,
                      color: _iconColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    offset: widget.isActive
                        ? Offset.zero
                        : const Offset(0, 0.4),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: widget.isActive ? 1.0 : 0.0,
                      child: Text(
                        widget.item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: widget.isActive
                              ? Colors.white
                              : (widget.isLight
                                  ? Colors.black38
                                  : Colors.white38),
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
    );
  }
}
