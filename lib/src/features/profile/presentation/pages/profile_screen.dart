import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/services/session_cubit.dart';
import 'package:codemap2/src/services/session_state.dart';
import 'package:codemap2/src/theme/app_theme.dart';
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme.primaryColor,
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "P R O F I L E",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      ? Colors.white.withOpacity(0.15)
                      : theme.primaryColor.withOpacity(0.4),
                  width: 4,
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
                  color: isDark
                      ? Colors.white.withOpacity(0.9)
                      : Colors.white,
                ),
                child: Icon(Icons.edit, color: theme.primaryColor, size: 20),
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
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 16,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.settings,
                text: "Settings",
                color: theme.primaryColor,
                onTap: () => context.push('/profile/settings'),
              ),
              ProfileMenuItem(
                icon: Icons.history,
                text: "My Learning",
                color: theme.primaryColor,
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.payment,
                text: "Billing",
                color: theme.primaryColor,
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.logout,
                text: "Logout",
                color: Colors.redAccent,
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
        Icon(
          Icons.account_circle_outlined,
          size: 100,
          color: theme.primaryColor.withOpacity(0.5),
        ),
        const SizedBox(height: 20),
        const Text(
          "Welcome, Guest",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "Log in to track your progress and access premium courses.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () => context.go('/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Log In / Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
