import 'package:flutter/material.dart';

class AuthSubtitle extends StatelessWidget {
  final String subtitle;
  final double fontSize;
  final Color color;

  const AuthSubtitle({
    Key? key,
    required this.subtitle,
    this.fontSize = 16,
    this.color = Colors.white70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
