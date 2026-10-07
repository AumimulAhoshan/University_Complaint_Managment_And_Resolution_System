import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;

  void _showEditProfileDialog() {
    final firstNameController =
    TextEditingController(text: 'Aumimul');
    final lastNameController =
    TextEditingController(text: 'Ahosan');
    final phoneController =
    TextEditingController(text: '+880 1712-345678');

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
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
                _buildDialogField(
                  controller: firstNameController,
                  label: 'First Name',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildDialogField(
                  controller: lastNameController,
                  label: 'Last Name',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 14),
                _buildDialogField(
                  controller: phoneController,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Profile updated successfully.',
                    ),
                    backgroundColor: AppColors.primaryDark,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogField({
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
        prefixIcon: Icon(icon),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          icon: const Icon(
            Icons.logout_rounded,
            color: AppColors.secondaryLight,
            size: 34,
          ),
          title: Text(
            'Logout',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to logout from your admin account?',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
              height: 1.45,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Admin Profile'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1024;
          final isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

          final horizontalPadding = isDesktop
              ? 32.0
              : isTablet
              ? 24.0
              : 16.0;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  32,
                ),
                child: isDesktop
                    ? _buildDesktopLayout()
                    : _buildMobileTabletLayout(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 18),
              _buildAccountInformation(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              _buildSystemPermissions(),
              const SizedBox(height: 18),
              _buildNotificationSettings(),
              const SizedBox(height: 18),
              _buildActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTabletLayout() {
    return Column(
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 18),
        _buildAccountInformation(),
        const SizedBox(height: 18),
        _buildSystemPermissions(),
        const SizedBox(height: 18),
        _buildNotificationSettings(),
        const SizedBox(height: 18),
        _buildActions(),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.12),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'AA',
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Aumimul Ahosan',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'System Administrator',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'ADMIN',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.secondaryLight,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showEditProfileDialog,
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Profile'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInformation() {
    return _buildSectionCard(
      title: 'Account Information',
      icon: Icons.account_circle_outlined,
      children: [
        _buildInfoRow(
          icon: Icons.badge_outlined,
          label: 'Admin ID',
          value: 'ADM-2021-001',
        ),
        _buildDivider(),
        _buildInfoRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'admin@uniserva.edu',
        ),
        _buildDivider(),
        _buildInfoRow(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: '+880 1712-345678',
        ),
        _buildDivider(),
        _buildInfoRow(
          icon: Icons.calendar_today_outlined,
          label: 'Joined',
          value: '15 January 2021',
        ),
      ],
    );
  }

  Widget _buildSystemPermissions() {
    return _buildSectionCard(
      title: 'System Access',
      icon: Icons.admin_panel_settings_outlined,
      children: [
        _buildPermissionRow(
          icon: Icons.people_outline_rounded,
          title: 'User Management',
          description: 'Manage student and staff accounts',
        ),
        _buildPermissionRow(
          icon: Icons.report_problem_outlined,
          title: 'Complaint Management',
          description: 'View and manage all complaints',
        ),
        _buildPermissionRow(
          icon: Icons.groups_outlined,
          title: 'Staff Management',
          description: 'Manage staff members and assignments',
        ),
        _buildPermissionRow(
          icon: Icons.analytics_outlined,
          title: 'Reports & Analytics',
          description: 'Access system reports and analytics',
        ),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return _buildSectionCard(
      title: 'Notification Settings',
      icon: Icons.notifications_outlined,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _pushNotifications,
          onChanged: (value) {
            setState(() {
              _pushNotifications = value;
            });
          },
          title: Text(
            'Push Notifications',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Receive important alerts in the app',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
        ),
        const Divider(
          color: AppColors.darkDivider,
          height: 1,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _emailNotifications,
          onChanged: (value) {
            setState(() {
              _emailNotifications = value;
            });
          },
          title: Text(
            'Email Notifications',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Receive important alerts by email',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return _buildSectionCard(
      title: 'Account Actions',
      icon: Icons.settings_outlined,
      children: [
        _buildActionTile(
          icon: Icons.lock_outline_rounded,
          title: 'Change Password',
          subtitle: 'Update your administrator password',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Change password will be available with the backend.',
                ),
                backgroundColor: AppColors.primaryDark,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            );
          },
        ),
        _buildActionTile(
          icon: Icons.security_outlined,
          title: 'Security Settings',
          subtitle: 'Manage account security preferences',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Security settings will be available later.',
                ),
                backgroundColor: AppColors.primaryDark,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            );
          },
        ),
        _buildActionTile(
          icon: Icons.logout_rounded,
          title: 'Logout',
          subtitle: 'Sign out of the admin account',
          iconColor: AppColors.error,
          onTap: _showLogoutDialog,
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: AppColors.secondaryLight,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.secondaryLight,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelLarge.copyWith(
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
      ),
    );
  }

  Widget _buildPermissionRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryLight,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.secondaryLight)
              .withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.secondaryLight,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: iconColor ?? AppColors.darkTextPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextSecondary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.darkTextTertiary,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.darkDivider,
      height: 1,
    );
  }
}