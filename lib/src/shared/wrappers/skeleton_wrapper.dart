import 'package:flutter/material.dart';

class SkeletonWrapper extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const SkeletonWrapper({
    super.key,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
