
import 'package:flutter/material.dart';

class progresshud extends StatelessWidget {
  final Widget? child;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color>? value;


  progresshud({
    this.child,
    this.inAsyncCall,
    this.opacity,
    this.color,
    this.value

});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
