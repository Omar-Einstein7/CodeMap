import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  Widget opacity(double value) => Opacity(opacity: value, child: this);

  Widget visible(bool visible, {Widget fallback = const SizedBox.shrink()}) =>
      visible ? this : fallback;

  Widget get center => Center(child: this);

  Widget get expanded => Expanded(child: this);

  Widget get fitted => FittedBox(child: this);

  Widget hero(Object tag) => Hero(tag: tag, child: this);

  Widget tooltip(String message) => Tooltip(message: message, child: this);
}
