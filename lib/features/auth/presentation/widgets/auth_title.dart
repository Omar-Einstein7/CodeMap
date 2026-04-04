import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;

  const AuthTitle({
    Key? key,
    required this.title,
    this.fontSize = 30,
    this.fontWeight,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      ),
    );
  }
}
