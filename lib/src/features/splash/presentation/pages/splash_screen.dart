import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/services/splash_cubit.dart';
import 'package:codemap2/src/services/splash_state.dart';
import 'package:codemap2/src/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: glassBackgroundGradient(isLight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.code_rounded,
                size: 100,
                color: isLight ? AppColors.primary : Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                "CodeMap",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  if (state is SplashInitial) {
                    return CircularProgressIndicator(
                      color: AppColors.primary,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
