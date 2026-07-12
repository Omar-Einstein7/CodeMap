import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool showArrow;
  final Color? color;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.showArrow = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.glassDark : AppColors.glassLight,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 25, color: color ?? theme.primaryColor),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                fontSize: 17,
              ),
            ),
            const Spacer(),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
              ),
          ],
        ),
      ),
    );
  }
}
