import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  String? _selectedDepartment;

  final List<String> _departments = [
    'Computer Science & Engineering',
    'Electrical & Electronic Engineering',
    'Software Engineering',
    'Business Administration',
    'English',
    'Law',
    'Civil Engineering',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Temporary mock registration.
    // Later this will connect to the Django registration API.
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceVariant,
          title: Text(
            'Registration Successful',
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          content: Text(
            'Your UniServa account has been created successfully. '
                'Please login to continue.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Continue',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    context.go('/login');
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must contain at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number';
    }

    // Special character validation.
    final specialCharacterRegex = RegExp(
      r'''[!@#$%^&*(),.?":{}|<>_\-\\/\[\]+=;'`~]''',
    );

    if (!specialCharacterRegex.hasMatch(value)) {
      return 'Password must contain a special character';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.white,
      ),
      cursorColor: AppColors.secondary,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.darkTextSecondary,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return _buildTextField(
      label: label,
      hint: hint,
      controller: controller,
      icon: Icons.lock_outline,
      validator: validator,
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.darkTextSecondary,
        ),
      ),
    );
  }

  Widget _buildDepartmentDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedDepartment,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Department is required';
        }

        return null;
      },
      dropdownColor: AppColors.surfaceVariant,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.white,
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.darkTextSecondary,
      ),
      decoration: const InputDecoration(
        labelText: 'Department',
        hintText: 'Select your department',
        prefixIcon: Icon(
          Icons.account_balance_outlined,
        ),
      ),
      items: _departments.map((department) {
        return DropdownMenuItem<String>(
          value: department,
          child: Text(
            department,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDepartment = value;
        });
      },
    );
  }

  Widget _buildRegisterForm() {
    final isMobile = Responsive.isMobile(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Create your UniServa student account',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),

          const SizedBox(height: 28),

          // First Name + Last Name
          if (isMobile)
            Column(
              children: [
                _buildTextField(
                  label: 'First Name',
                  hint: 'Enter your first name',
                  controller: _firstNameController,
                  icon: Icons.person_outline,
                  validator: (value) {
                    return _validateRequired(value, 'First name');
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  controller: _lastNameController,
                  icon: Icons.person_outline,
                  validator: (value) {
                    return _validateRequired(value, 'Last name');
                  },
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'First Name',
                    hint: 'Enter your first name',
                    controller: _firstNameController,
                    icon: Icons.person_outline,
                    validator: (value) {
                      return _validateRequired(value, 'First name');
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    label: 'Last Name',
                    hint: 'Enter your last name',
                    controller: _lastNameController,
                    icon: Icons.person_outline,
                    validator: (value) {
                      return _validateRequired(value, 'Last name');
                    },
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

          // Student ID + Department
          if (isMobile)
            Column(
              children: [
                _buildTextField(
                  label: 'Student ID',
                  hint: 'Enter your student ID',
                  controller: _studentIdController,
                  icon: Icons.badge_outlined,
                  validator: (value) {
                    return _validateRequired(value, 'Student ID');
                  },
                ),
                const SizedBox(height: 16),
                _buildDepartmentDropdown(),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Student ID',
                    hint: 'Enter your student ID',
                    controller: _studentIdController,
                    icon: Icons.badge_outlined,
                    validator: (value) {
                      return _validateRequired(value, 'Student ID');
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDepartmentDropdown(),
                ),
              ],
            ),

          const SizedBox(height: 16),

          // Email
          _buildTextField(
            label: 'Email Address',
            hint: 'Enter your university email',
            controller: _emailController,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),

          const SizedBox(height: 16),

          // Phone
          _buildTextField(
            label: 'Phone Number',
            hint: 'Enter your phone number',
            controller: _phoneController,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              return _validateRequired(value, 'Phone number');
            },
          ),

          const SizedBox(height: 16),

          // Password + Confirm Password
          if (isMobile)
            Column(
              children: [
                _buildPasswordField(
                  label: 'Password',
                  hint: 'Create a strong password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword =
                      !_obscureConfirmPassword;
                    });
                  },
                  validator: _validateConfirmPassword,
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildPasswordField(
                    label: 'Password',
                    hint: 'Create a strong password',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    validator: _validatePassword,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPasswordField(
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    onToggle: () {
                      setState(() {
                        _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                      });
                    },
                    validator: _validateConfirmPassword,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 24),

          // Register button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: _isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              )
                  : const Text('Create Account'),
            ),
          ),

          const SizedBox(height: 20),

          // Login link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: Text(
                  'Login',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 38,
            color: AppColors.white,
          ),
        ),

        const SizedBox(height: 28),

        Text(
          'Join UniServa',
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Create your student account and get access to a smarter '
              'way to submit, track, and manage university services '
              'and complaints.',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: 28),

        _buildBenefit(
          Icons.assignment_outlined,
          'Submit complaints easily',
        ),

        _buildBenefit(
          Icons.track_changes_outlined,
          'Track complaint progress',
        ),

        _buildBenefit(
          Icons.notifications_none_rounded,
          'Receive important updates',
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
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: _buildRegisterForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.horizontalPadding(context),
              vertical: 32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1100,
              ),
              child: isDesktop
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
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