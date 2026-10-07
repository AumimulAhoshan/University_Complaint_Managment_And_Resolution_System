import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 2),
      _checkAuthentication,
    );
  }

  void _checkAuthentication() {
    if (!mounted) return;

    // TODO:
    // Later this will check the stored Django JWT token.
    //
    // For now, every new session goes to Login.
    context.go('/login');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ========================================================
                // LOGO
                // ========================================================

                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.white.withValues(
                        alpha: 0.20,
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 48,
                    color: AppColors.white,
                  ),
                ),

                const SizedBox(height: 28),

                // ========================================================
                // APP NAME
                // ========================================================

                Text(
                  'UniServa',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                // ========================================================
                // TAGLINE
                // ========================================================

                Text(
                  'University Service &\nComplaint Management',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white.withValues(
                      alpha: 0.85,
                    ),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 48),

                // ========================================================
                // LOADING INDICATOR
                // ========================================================

                SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.white.withValues(
                        alpha: 0.90,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}