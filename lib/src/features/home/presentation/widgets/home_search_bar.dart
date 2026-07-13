import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  const HomeSearchBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: theme.glassColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.glassBorder),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: theme.textTertiaryColor,
            ),
            const SizedBox(width: 15),
            Text(
              "Search for courses...",
              style: TextStyle(
                color: theme.textTertiaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
