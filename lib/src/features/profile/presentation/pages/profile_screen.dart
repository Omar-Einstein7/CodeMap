import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, sessionState) {
        return Scaffold(
          backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
          body: GlassBackground(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "P R O F I L E",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (sessionState is SessionAuthenticated) ...[
                    _buildAuthenticatedProfile(context, theme, isDark, sessionState),
                  ] else ...[
                    _buildGuestProfile(context, theme),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAuthenticatedProfile(
    BuildContext context,
    ThemeData theme,
    bool isDark,
    SessionAuthenticated state,
  ) {
    final user = state.user;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : theme.colorScheme.primary.withValues(alpha: 0.3),
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                backgroundImage: user.profileImageUrl != null
                    ? NetworkImage(user.profileImageUrl!) as ImageProvider
                    : const AssetImage(
                        "images/Screenshot 2023-04-07 021621.png",
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary,
                  border: Border.all(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          user.fullName,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.textPrimaryColor,
          ),
        ),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 15,
            color: theme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.settings_outlined,
                text: "Settings",
                color: theme.colorScheme.primary,
                onTap: () => context.push('/profile/settings'),
              ),
              ProfileMenuItem(
                icon: Icons.history_rounded,
                text: "My Learning",
                color: theme.colorScheme.primary,
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.payment_rounded,
                text: "Billing",
                color: theme.colorScheme.primary,
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.logout_rounded,
                text: "Logout",
                color: AppColors.error,
                onTap: () {
                  context.read<SessionCubit>().clearSession();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuestProfile(BuildContext context, ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.glassColor,
            border: Border.all(color: theme.glassBorder),
          ),
          child: Icon(
            Icons.person_outline_rounded,
            size: 80,
            color: theme.textTertiaryColor,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Welcome, Guest",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "Log in to track your progress and access premium courses.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: theme.textSecondaryColor,
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 200,
          height: 52,
          child: ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text(
              "Log In / Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
