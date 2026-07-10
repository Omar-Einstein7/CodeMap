import 'package:flutter/material.dart';

class AppNavigator {
  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static void pushReplacementNamed(
    BuildContext context,
    String routeName, {
    Object? result,
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(context, routeName , result: result , arguments: arguments);
  }

  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushnamed(BuildContext context, String route, Object? arguments) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static void pushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }
}
