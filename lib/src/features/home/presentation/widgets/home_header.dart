import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  final String username;
  const HomeHeader({Key? key, this.username = 'Omar Ahmed'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back,",
                style: TextStyle(
                  fontSize: 16,
                  color: isLight ? Colors.grey[600] : Colors.grey[400],
                ),
              ),
              Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isLight ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isLight
                  ? AppColors.glassLight
                  : AppColors.glassDark,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isLight
                    ? AppColors.glassBorderLight
                    : AppColors.glassBorderDark,
              ),
            ),
            child: Icon(Icons.notifications, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
