import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;

  const AuthTitle({
    super.key,
    required this.title,
    this.fontSize = 30,
    this.fontWeight,
    this.color = Colors.white,
  });

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

class AuthSubtitle extends StatelessWidget {
  final String subtitle;
  final double fontSize;
  final Color color;

  const AuthSubtitle({
    super.key,
    required this.subtitle,
    this.fontSize = 16,
    this.color = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final Color backgroundColor;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.backgroundColor = const Color(0xff0E86D4),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
