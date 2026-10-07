import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  Future<void> _sendResetLink() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Temporary mock behavior.
    // Later this will call the Django password-reset API.
    await Future.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      cursorColor: AppColors.primarySurface,
      validator: _validateEmail,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your registered email',
        prefixIcon: const Icon(
          Icons.email_outlined,
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextTertiary,
        ),
        prefixIconColor: AppColors.darkTextSecondary,
        filled: true,
        fillColor: AppColors.surfaceVariant,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.darkBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primarySurface,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.overlay,
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: _emailSent
          ? _buildSuccessContent()
          : _buildResetForm(),
    );
  }

  Widget _buildResetForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              color: AppColors.textPrimary,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Forgot Password?',
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.primarySurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter your registered email address and we will '
                'send you a link to reset your password.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 28),
          _buildEmailField(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  _sendResetLink();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySurface,
                foregroundColor: AppColors.textPrimary,
                disabledBackgroundColor:
                AppColors.primarySurface.withValues(
                  alpha: 0.55,
                ),
                disabledForegroundColor:
                AppColors.textPrimary.withValues(
                  alpha: 0.65,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.textPrimary,
                ),
              )
                  : const Text(
                'Send Reset Link',
              ),
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: TextButton.icon(
              onPressed: _isLoading
                  ? null
                  : () {
                context.go('/login');
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primarySurface,
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 18,
              ),
              label: const Text(
                'Back to Login',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(
              alpha: 0.18,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            color: AppColors.success,
            size: 36,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Check Your Email',
          textAlign: TextAlign.center,
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.primarySurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'We have sent a password reset link to:',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _emailController.text.trim(),
          textAlign: TextAlign.center,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.primarySurface,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Please check your inbox and follow the instructions '
              'to reset your password.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              context.go('/reset-password');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primarySurface,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Continue to Reset Password',
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            setState(() {
              _emailSent = false;
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primarySurface,
          ),
          child: const Text(
            'Use a different email',
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.security_rounded,
            size: 38,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Secure Your Account',
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.primarySurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'No worries. Password recovery is simple and secure. '
              'Enter the email connected to your UniServa account '
              'and we will help you get back in.',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
        const SizedBox(height: 28),
        _buildBenefit(
          Icons.mark_email_read_outlined,
          'Receive a secure reset link',
        ),
        _buildBenefit(
          Icons.lock_outline_rounded,
          'Create a new password',
        ),
        _buildBenefit(
          Icons.login_rounded,
          'Return securely to your account',
        ),
      ],
    );
  }

  Widget _buildBenefit(
      IconData icon,
      String text,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primarySurface.withValues(
                alpha: 0.14,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primarySurface,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal:
              Responsive.horizontalPadding(context),
              vertical: 32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),
              child: isDesktop
                  ? Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(
                        right: 56,
                      ),
                      child: _buildWelcomeSection(),
                    ),
                  ),
                  Expanded(
                    child: _buildFormCard(),
                  ),
                ],
              )
                  : _buildFormCard(),
            ),
          ),
        ),
      ),
    );
  }
}