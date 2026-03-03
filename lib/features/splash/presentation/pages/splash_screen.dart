import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the splash provider and navigate when the initial logic is done.
    ref.listen<AsyncValue<String>>(splashProvider, (previous, next) {
      next.whenData((routeName) {
        // We use Navigator.pushReplacementNamed because we haven't refactored routing to go_router yet.
        // This maintains compatibility with the existing route system in main.dart.
        Navigator.of(context).pushReplacementNamed(routeName);
      });
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Logo or Lottie animation.
            // Using a simple icon for now to avoid asset dependency issues.
            Icon(
              Icons.code_rounded,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              "CodeMap",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
