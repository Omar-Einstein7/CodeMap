import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  const HomeSearchBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isLight
              ? Colors.black.withOpacity(0.05)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: isLight ? Colors.black54 : Colors.white54,
            ),
            const SizedBox(width: 15),
            Text(
              "Search for courses...",
              style: TextStyle(
                color: isLight ? Colors.black54 : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
