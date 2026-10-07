import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'''[!@#$%^&*(),.?":{}|<>_\-\\/\[\]+=;'`~]''')
            .hasMatch(password);
  }

  Future<void> _resetPassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Temporary mock delay.
    // Later this will call the Django REST API.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: const Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.secondary,
            size: 56,
          ),
          title: Text(
            'Password Reset Successful',
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.darkTextPrimary,
            ),
          ),
          content: Text(
            'Your password has been updated successfully. '
                'You can now log in with your new password.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarySurface,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Go to Login'),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    context.go('/login');
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      validator: validator,
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      cursorColor: AppColors.primarySurface,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
        ),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextTertiary,
        ),
        prefixIconColor: AppColors.darkTextSecondary,
        suffixIconColor: AppColors.darkTextSecondary,
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

  Widget _buildPasswordRequirements() {
    final password = _passwordController.text;

    final requirements = <Map<String, dynamic>>[
      {
        'text': 'At least 8 characters',
        'valid': password.length >= 8,
      },
      {
        'text': 'One uppercase letter',
        'valid': RegExp(r'[A-Z]').hasMatch(password),
      },
      {
        'text': 'One lowercase letter',
        'valid': RegExp(r'[a-z]').hasMatch(password),
      },
      {
        'text': 'One number',
        'valid': RegExp(r'[0-9]').hasMatch(password),
      },
      {
        'text': 'One special character',
        'valid': RegExp(
          r'''[!@#$%^&*(),.?":{}|<>_\-\\/\[\]+=;'`~]''',
        ).hasMatch(password),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password requirements',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.darkTextPrimary,
            ),
          ),
          const SizedBox(height: 10),
          ...requirements.map(
                (requirement) {
              final valid = requirement['valid'] as bool;

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      valid
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      size: 17,
                      color: valid
                          ? AppColors.success
                          : AppColors.darkTextTertiary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        requirement['text'] as String,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: valid
                              ? AppColors.success
                              : AppColors.darkTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPasswordField(
            label: 'New Password',
            hint: 'Enter your new password',
            controller: _passwordController,
            obscureText: !_showPassword,
            onToggleVisibility: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a new password';
              }

              if (!_isStrongPassword(value)) {
                return 'Password does not meet the requirements';
              }

              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildPasswordRequirements(),
          const SizedBox(height: 16),
          _buildPasswordField(
            label: 'Confirm Password',
            hint: 'Re-enter your new password',
            controller: _confirmPasswordController,
            obscureText: !_showConfirmPassword,
            onToggleVisibility: () {
              setState(() {
                _showConfirmPassword =
                !_showConfirmPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }

              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _resetPassword,
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
                  : const Text('Reset Password'),
            ),
          ),
          const SizedBox(height: 14),
          TextButton.icon(
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
            ),
            label: const Text(
              'Back to Login',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 88,
          width: 88,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: AppColors.overlay,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_reset_rounded,
            size: 46,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Create a New Password',
          textAlign: TextAlign.center,
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.primarySurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Choose a strong password to keep your '
              'UniServa account secure.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
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
              flex: 5,
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.all(48),
                child: _buildBranding(),
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(48),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: _buildForm(),
                  ),
                ),
              ),
            ),
          ],
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 28),
              _buildBranding(),
              const SizedBox(height: 36),
              Container(
                padding: const EdgeInsets.all(20),
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
                child: _buildForm(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}