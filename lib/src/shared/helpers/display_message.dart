import 'package:flutter/material.dart';

class DisplayMessage {
  static void errorMessage(String message, BuildContext context) {
    final theme = Theme.of(context);
    var snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.white,
        ),
      ),
      backgroundColor: theme.colorScheme.error,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
