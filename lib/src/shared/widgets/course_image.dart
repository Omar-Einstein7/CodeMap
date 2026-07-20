import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const CourseImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius = 0,
  });

  bool get _isNetwork => imageUrl.startsWith('http');
  bool get _isSvg => _isNetwork && imageUrl.endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget image;
    if (_isSvg) {
      image = SvgPicture.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholderBuilder: (_) => _placeholder(isDark),
      );
    } else if (_isNetwork) {
      image = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _placeholder(isDark),
        loadingBuilder: (_, child, progress) =>
            progress == null ? child : _placeholder(isDark),
      );
    } else {
      image = Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _placeholder(isDark),
      );
    }

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }
    return image;
  }

  Widget _placeholder(bool isDark) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[200],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.code_rounded,
        color: isDark ? Colors.grey[600] : Colors.grey[400],
      ),
    );
  }
}
