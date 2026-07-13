import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class HomeScreenSkeleton extends StatefulWidget {
  const HomeScreenSkeleton({super.key});

  @override
  State<HomeScreenSkeleton> createState() => _HomeScreenSkeletonState();
}

class _HomeScreenSkeletonState extends State<HomeScreenSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => _buildSkeleton(context),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final theme = Theme.of(context);
    final opacity = _animation.value;
    final baseColor = theme.glassColor.withValues(alpha: opacity);

    Widget skeletonBox({
      double? width,
      double? height,
      double borderRadius = 12,
      EdgeInsets? margin,
    }) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      skeletonBox(width: 100, height: 14),
                      const SizedBox(height: 6),
                      skeletonBox(width: 140, height: 20),
                    ],
                  ),
                  skeletonBox(width: 44, height: 44, borderRadius: 22),
                ],
              ),
            ),

            // Search bar skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: skeletonBox(width: double.infinity, height: 48, borderRadius: 28),
            ),

            // Banner skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Row(
                  children: [
                    Expanded(
                      child: skeletonBox(borderRadius: 20),
                    ),
                  ],
                ),
              ),
            ),

            // Category selector skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: skeletonBox(width: double.infinity, height: 36, borderRadius: 18),
            ),

            // Featured courses title skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: skeletonBox(width: 160, height: 20),
            ),

            // Featured courses horizontal list skeleton
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 17),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (_, __) => Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: baseColor.withValues(alpha: 0.5),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: double.infinity,
                            height: 14,
                            decoration: BoxDecoration(
                              color: baseColor.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Recent courses title skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  skeletonBox(width: 140, height: 20),
                  skeletonBox(width: 50, height: 16),
                ],
              ),
            ),

            // Recent courses list skeleton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(4, (_) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        skeletonBox(width: 70, height: 70, borderRadius: 15),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              skeletonBox(width: 120, height: 14),
                              const SizedBox(height: 8),
                              skeletonBox(width: 90, height: 12),
                            ],
                          ),
                        ),
                        skeletonBox(width: 32, height: 32, borderRadius: 16),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
