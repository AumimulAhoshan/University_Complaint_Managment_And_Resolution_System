import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    // Temporary login simulation.
    // No email or password is required for now.
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // Temporary navigation.
    // Later this will be replaced with Django JWT authentication.
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: isDesktop
            ? Row(
          children: [
            Expanded(
              child: _buildWelcomeSection(),
            ),
            Expanded(
              child: _buildLoginSection(),
            ),
          ],
        )
            : _buildLoginSection(),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // WELCOME SECTION
  // ---------------------------------------------------------------------------

  Widget _buildWelcomeSection() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
        vertical: 40,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.white.withValues(
                      alpha: 0.18,
                    ),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 54,
                  color: AppColors.white,
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Welcome to UniServa',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'University Service & Complaint\nManagement System',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.white.withValues(
                    alpha: 0.85,
                  ),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(
                    alpha: 0.08,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.white.withValues(
                      alpha: 0.10,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      color: AppColors.primarySurface,
                      size: 19,
                    ),
                    const SizedBox(width: 9),
                    Text(
                      'Simple • Secure • Connected',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white.withValues(
                          alpha: 0.9,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LOGIN SECTION
  // ---------------------------------------------------------------------------

  Widget _buildLoginSection() {
    return Container(
      color: AppColors.primaryDark,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 480,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.darkBorder,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(
                      alpha: 0.20,
                    ),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // -----------------------------------------------------------------
                    // HEADER
                    // -----------------------------------------------------------------

                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.lock_open_rounded,
                            color: AppColors.primarySurface,
                            size: 23,
                          ),
                        ),

                        const SizedBox(width: 13),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color:
                                  AppColors.primarySurface,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                'Sign in to continue to UniServa',
                                style: AppTextStyles.bodyMedium
                                    .copyWith(
                                  color: AppColors
                                      .darkTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // -----------------------------------------------------------------
                    // EMAIL
                    // -----------------------------------------------------------------

                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _emailController,
                      keyboardType:
                      TextInputType.emailAddress,
                      textInputAction:
                      TextInputAction.next,
                      style: const TextStyle(
                        color: AppColors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(
                          color: AppColors.darkTextTertiary,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.darkTextSecondary,
                        ),
                        filled: true,
                        fillColor:
                        AppColors.surfaceVariant,
                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.darkBorder,
                          ),
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color:
                            AppColors.primarySurface,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // -----------------------------------------------------------------
                    // PASSWORD
                    // -----------------------------------------------------------------

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction:
                      TextInputAction.done,
                      onSubmitted: (_) {
                        if (!_isLoading) {
                          _login();
                        }
                      },
                      style: const TextStyle(
                        color: AppColors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(
                          color: AppColors.darkTextTertiary,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.darkTextSecondary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                              !_obscurePassword;
                            });
                          },
                          color:
                          AppColors.darkTextSecondary,
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        filled: true,
                        fillColor:
                        AppColors.surfaceVariant,
                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.darkBorder,
                          ),
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color:
                            AppColors.primarySurface,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // -----------------------------------------------------------------
                    // FORGOT PASSWORD
                    // -----------------------------------------------------------------

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.push(
                            '/forgot-password',
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                          AppColors.primarySurface,
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Forgot Password?',
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // -----------------------------------------------------------------
                    // LOGIN BUTTON
                    // -----------------------------------------------------------------

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed:
                        _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.primarySurface,
                          foregroundColor:
                          AppColors.textPrimary,
                          disabledBackgroundColor:
                          AppColors.primarySurface
                              .withValues(
                            alpha: 0.55,
                          ),
                          disabledForegroundColor:
                          AppColors.textPrimary
                              .withValues(
                            alpha: 0.65,
                          ),
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color:
                            AppColors.textPrimary,
                          ),
                        )
                            : const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // -----------------------------------------------------------------
                    // DIVIDER
                    // -----------------------------------------------------------------

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.darkBorder,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            'OR',
                            style: AppTextStyles.bodyMedium
                                .copyWith(
                              color: AppColors
                                  .darkTextTertiary,
                              fontSize: 11,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.darkBorder,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // -----------------------------------------------------------------
                    // REGISTER
                    // -----------------------------------------------------------------

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: AppTextStyles.bodyMedium
                              .copyWith(
                            color:
                            AppColors.darkTextSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/register');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                            AppColors.primarySurface,
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 6,
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}