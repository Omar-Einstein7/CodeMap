import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/theme/app_theme.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

// ─── Shell ────────────────────────────────────────────────────────────────────

class NavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationShell({super.key, required this.navigationShell});

  static const _items = <_NavItem>[
    _NavItem(icon: Icons.home_rounded,         label: 'Home'),
    _NavItem(icon: Icons.favorite_rounded,      label: 'Favourites'),
    _NavItem(icon: Icons.library_books_rounded, label: 'Courses'),
    _NavItem(icon: Icons.person_rounded,        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme   = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? AppColors.bgLight : AppColors.bgDark,
      extendBody: true,
      body: navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _LiquidNavBar(
        items:         _items,
        activeIndex:   navigationShell.currentIndex,
        primaryColor:  theme.colorScheme.primary,
        secondaryColor: theme.colorScheme.secondary,
        isLight:       isLight,
        onTap:         (i) => navigationShell.goBranch(i),
      ),
    );
  }
}

// ─── Nav Bar ──────────────────────────────────────────────────────────────────

class _LiquidNavBar extends StatefulWidget {
  final List<_NavItem>    items;
  final int               activeIndex;
  final Color             primaryColor;
  final Color             secondaryColor;
  final bool              isLight;
  final ValueChanged<int> onTap;

  const _LiquidNavBar({
    required this.items,
    required this.activeIndex,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isLight,
    required this.onTap,
  });

  @override
  State<_LiquidNavBar> createState() => _LiquidNavBarState();
}

class _LiquidNavBarState extends State<_LiquidNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _slideAnim = Tween<double>(
      begin: widget.activeIndex.toDouble(),
      end:   widget.activeIndex.toDouble(),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic));
  }

  @override
  void didUpdateWidget(_LiquidNavBar old) {
    super.didUpdateWidget(old);
    if (old.activeIndex != widget.activeIndex) {
      _slideAnim = Tween<double>(
        begin: _slideAnim.value,
        end:   widget.activeIndex.toDouble(),
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic));
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  LiquidGlassSettings get _glassSettings => LiquidGlassSettings(
    thickness:          22,
    blur:               14,
    glassColor:         widget.isLight
        ? const Color(0x28000000)  // subtle dark tint → white icons pop
        : const Color(0x35000000),
    lightIntensity:     1.8,
    lightAngle:         2.4,
    ambientStrength:    0.15,
    saturation:         1.2,
    chromaticAberration: 0.008,
  );

  @override
  Widget build(BuildContext context) {
    final count = widget.items.length;

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 26),
      child: SizedBox(
        height: 80,
        child: LayoutBuilder(
          builder: (context, box) {
            final totalW = box.maxWidth;
            final cellW  = totalW / count;
            final blobW  = cellW - 10;
            const blobH  = 62.0;

            return LiquidGlassLayer(
              settings: _glassSettings,
              child: LiquidGlassBlendGroup(
                blend: 26,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned.fill(
                      child: LiquidGlass.grouped(
                        shape: LiquidRoundedSuperellipse(borderRadius: 28),
                        child: SizedBox.expand(),
                      ),
                    ),

                    AnimatedBuilder(
                      animation: _slideAnim,
                      builder: (_, __) {
                        final blobLeft =
                            _slideAnim.value * cellW + (cellW - blobW) / 2;
                        return Positioned(
                          left: blobLeft,
                          top:  (80 - blobH) / 2,
                          child: LiquidGlass.grouped(
                            shape: const LiquidRoundedSuperellipse(borderRadius: 20),
                            glassContainsChild: true,
                            child: Container(
                              width:  blobW,
                              height: blobH,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end:   Alignment.bottomRight,
                                  colors: [
                                    widget.secondaryColor
                                        .withValues(alpha: 0.88),
                                    widget.primaryColor
                                        .withValues(alpha: 0.96),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Row(
                      children: List.generate(count, (i) {
                        final isActive = i == widget.activeIndex;
                        return Expanded(
                          child: _NavTab(
                            item:     widget.items[i],
                            isActive: isActive,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              widget.onTap(i);
                            },
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Single tab item ──────────────────────────────────────────────────────────

class _NavTab extends StatefulWidget {
  final _NavItem     item;
  final bool         isActive;
  final VoidCallback onTap;

  const _NavTab({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl = AnimationController(
    vsync: this,
    duration:        const Duration(milliseconds: 100),
    reverseDuration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _pressAnim = Tween<double>(
    begin: 1.0, end: 0.87,
  ).animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button:   true,
      selected: widget.isActive,
      label:    widget.item.label,
      child: GestureDetector(
        behavior:    HitTestBehavior.opaque,
        onTapDown:   (_) => _pressCtrl.forward(),
        onTapUp:     (_) { _pressCtrl.reverse(); widget.onTap(); },
        onTapCancel: ()  => _pressCtrl.reverse(),
        child: ScaleTransition(
          scale: _pressAnim,
          child: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale:    widget.isActive ? 1.16 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve:    Curves.easeOutBack,
                  child: Icon(
                    widget.item.icon,
                    size:  24,
                    color: Colors.white.withValues(
                      alpha: widget.isActive ? 1.0 : 0.55,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  style: TextStyle(
                    fontSize:      widget.isActive ? 11 : 10,
                    fontWeight:    widget.isActive
                        ? FontWeight.w700 : FontWeight.w400,
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
