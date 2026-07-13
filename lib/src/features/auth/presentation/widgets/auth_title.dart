import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const AuthTitle({
    Key? key,
    required this.title,
    this.fontSize = 30,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Theme.of(context).textPrimaryColor),
      ),
    );
  }
}
