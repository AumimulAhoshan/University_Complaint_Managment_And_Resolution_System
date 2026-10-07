import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _fullName = 'Aumimul Ahoshan';
  String _studentId = 'STU-2024-001';
  String _department = 'Computer Science & Engineering';
  String _email = 'aumimul@example.com';
  String _phone = '+880 1712-345678';

  String get _initials {
    final parts = _fullName.trim().split(RegExp(r'\s+'));

    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }

    return parts.isNotEmpty && parts.first.isNotEmpty
        ? parts.first[0].toUpperCase()
        : 'U';
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _fullName);
    final studentIdController = TextEditingController(text: _studentId);
    final departmentController = TextEditingController(text: _department);
    final emailController = TextEditingController(text: _email);
    final phoneController = TextEditingController(text: _phone);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Edit Profile',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEditField(
                  controller: nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildEditField(
                  controller: studentIdController,
                  label: 'Student ID',
                  icon: Icons.badge_outlined,
                ),
                const SizedBox(height: 14),
                _buildEditField(
                  controller: departmentController,
                  label: 'Department',
                  icon: Icons.school_outlined,
                ),
                const SizedBox(height: 14),
                _buildEditField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 14),
                _buildEditField(
                  controller: phoneController,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _fullName = nameController.text.trim();
                  _studentId = studentIdController.text.trim();
                  _department = departmentController.text.trim();
                  _email = emailController.text.trim();
                  _phone = phoneController.text.trim();
                });

                Navigator.of(dialogContext).pop();

                _showMessage('Profile updated successfully');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySurface,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.darkTextSecondary,
        ),
        filled: true,
        fillColor: AppColors.darkBackgroundSecondary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.darkBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.primarySurface,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Log Out',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.go('/login');
              },
              icon: const Icon(
                Icons.logout_rounded,
              ),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                // Same logout color as Staff Profile
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkSurface,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 1024
                ? 40.0
                : constraints.maxWidth >= 600
                ? 28.0
                : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 900,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildProfileHeader(),
                      const SizedBox(height: 24),
                      _buildStudentInformation(),
                      const SizedBox(height: 20),
                      _buildAccountSettings(),
                      const SizedBox(height: 24),
                      _buildLogoutButton(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.primarySurface,
            child: Text(
              _initials,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _fullName,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 21,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            _studentId,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: _showEditProfileDialog,
            icon: const Icon(
              Icons.edit_outlined,
            ),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primarySurface,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInformation() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Information',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            icon: Icons.person_outline_rounded,
            label: 'Full Name',
            value: _fullName,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.badge_outlined,
            label: 'Student ID',
            value: _studentId,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.school_outlined,
            label: 'Department',
            value: _department,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: _email,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: _phone,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.darkBackgroundSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primarySurface,
            size: 21,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextTertiary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          _buildSettingsTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
            onTap: () {
              context.push('/student/notifications');
            },
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(
            icon: Icons.lock_outline_rounded,
            title: 'Change Password',
            subtitle: 'Update your account password',
            onTap: () {
              _showMessage('Password change will be available soon');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.darkBackgroundSecondary,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primarySurface,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.darkTextTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(
          Icons.logout_rounded,
        ),
        label: const Text('Log Out'),
        style: ElevatedButton.styleFrom(
          // Same filled red color as Staff Profile
          backgroundColor: AppColors.error,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}