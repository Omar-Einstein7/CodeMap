import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:codemap2/src/theme/app_theme.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/shared/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isLightTheme) {
        return GlassScaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: theme.textPrimaryColor,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSettingItem(
                context,
                icon: Icons.dark_mode_rounded,
                title: "Dark Mode",
                trailing: Switch(
                  value: !isLightTheme,
                  onChanged: (value) =>
                      context.read<ThemeCubit>().toggleTheme(),
                  activeThumbColor: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                icon: Icons.language_rounded,
                title: "Language",
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.textTertiaryColor,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                icon: Icons.notifications_outlined,
                title: "Notifications",
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.textTertiaryColor,
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.glassColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.glassBorder),
      ),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            color: theme.textPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
