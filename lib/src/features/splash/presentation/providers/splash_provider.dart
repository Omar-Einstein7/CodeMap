import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

/// Provider for managing splash logic.
/// Decides which screen to navigate to based on the user's auth status or onboarding.
final splashProvider = FutureProvider<String>((ref) async {
  // Simulate some initial loading time (e.g., fetching initial config)
  await Future.delayed(const Duration(seconds: 2));

  // Use GetIt to get SharedPreferences as we migrated to GetIt for DI
  final prefs = GetIt.instance<SharedPreferences>();

  // Check if user is logged in (simplified for now)
  final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  if (isLoggedIn) {
    return 'Main';
  } else {
    return 'Login';
  }
});
