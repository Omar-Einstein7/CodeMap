import 'package:flutter/material.dart';

extension NumExtension on num {
  Widget get kH => SizedBox(height: toDouble());
  Widget get kW => SizedBox(width: toDouble());

  BorderRadius get radius => BorderRadius.circular(toDouble());

  Duration get ms => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
}
