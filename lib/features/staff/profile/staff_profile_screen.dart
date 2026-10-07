import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class StaffProfileScreen extends StatefulWidget {
  const StaffProfileScreen({super.key});

  @override
  State<StaffProfileScreen> createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen> {
  bool _notificationsEnabled = true;
  bool _emailUpdatesEnabled = true;

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
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
            'Logout',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to logout from your staff account?',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
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
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.16),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.45),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                'MA',
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Mahmud Ahmed',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'IT Support Officer',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'STAFF',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
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
            color: AppColors.secondary.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.secondary,
            size: 21,
          ),
        ),
        const SizedBox(width: 13),
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
                style: AppTextStyles.bodyLarge.copyWith(
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

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.secondary,
                  size: 21,
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
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildStaffInformation() {
    return _buildSectionCard(
      title: 'Staff Information',
      icon: Icons.badge_outlined,
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.person_outline_rounded,
            label: 'Full Name',
            value: 'Mahmud Ahmed',
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            icon: Icons.badge_outlined,
            label: 'Staff ID',
            value: 'STF-2021-017',
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            icon: Icons.work_outline_rounded,
            label: 'Designation',
            value: 'IT Support Officer',
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            icon: Icons.business_outlined,
            label: 'Department',
            value: 'Information Technology',
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_mail_outlined,
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'mahmud@university.edu',
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: '+880 1700-123456',
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Office',
            value: 'IT Support Office, Admin Building',
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return _buildSectionCard(
      title: 'Work Statistics',
      icon: Icons.bar_chart_rounded,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 420;

          final items = [
            _StatItem(
              value: '18',
              label: 'Assigned',
              color: AppColors.assigned,
              icon: Icons.assignment_outlined,
            ),
            _StatItem(
              value: '07',
              label: 'In Progress',
              color: AppColors.inProgress,
              icon: Icons.pending_actions_outlined,
            ),
            _StatItem(
              value: '32',
              label: 'Resolved',
              color: AppColors.resolved,
              icon: Icons.check_circle_outline_rounded,
            ),
            _StatItem(
              value: '03',
              label: 'Overdue',
              color: AppColors.error,
              icon: Icons.warning_amber_rounded,
            ),
          ];

          if (compact) {
            return Column(
              children: items
                  .map(
                    (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildStatItem(item),
                ),
              )
                  .toList(),
            );
          }

          return Row(
            children: items
                .map(
                  (item) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildStatItem(item),
                ),
              ),
            )
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(_StatItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        children: [
          Icon(
            item.icon,
            color: item.color,
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            item.value,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return _buildSectionCard(
      title: 'Preferences',
      icon: Icons.settings_outlined,
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });

              _showMessage(
                value
                    ? 'Notifications enabled.'
                    : 'Notifications disabled.',
              );
            },
            activeThumbColor: AppColors.secondary,
            activeTrackColor: AppColors.secondary.withValues(alpha: 0.35),
            inactiveThumbColor: AppColors.darkTextTertiary,
            inactiveTrackColor: AppColors.darkSurfaceVariant,
            title: Text(
              'Push Notifications',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Receive complaint and assignment notifications.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
          const Divider(
            color: AppColors.darkDivider,
            height: 24,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _emailUpdatesEnabled,
            onChanged: (value) {
              setState(() {
                _emailUpdatesEnabled = value;
              });

              _showMessage(
                value
                    ? 'Email updates enabled.'
                    : 'Email updates disabled.',
              );
            },
            activeThumbColor: AppColors.secondary,
            activeTrackColor: AppColors.secondary.withValues(alpha: 0.35),
            inactiveThumbColor: AppColors.darkTextTertiary,
            inactiveTrackColor: AppColors.darkSurfaceVariant,
            title: Text(
              'Email Updates',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Receive important updates through email.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                _showMessage('Edit profile will be available with the backend.');
              },
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Profile'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.secondary,
                side: BorderSide(
                  color: AppColors.secondary.withValues(alpha: 0.6),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _showLogoutDialog,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool desktop) {
    if (desktop) {
      return Column(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildStaffInformation(),
                    const SizedBox(height: 18),
                    _buildContactInformation(),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  children: [
                    _buildStatistics(),
                    const SizedBox(height: 18),
                    _buildSettings(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildActionCard(),
        ],
      );
    }

    return Column(
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 18),
        _buildStaffInformation(),
        const SizedBox(height: 18),
        _buildContactInformation(),
        const SizedBox(height: 18),
        _buildStatistics(),
        const SizedBox(height: 18),
        _buildSettings(),
        const SizedBox(height: 18),
        _buildActionCard(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        title: Text(
          'Staff Profile',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth >= 1000;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: desktop ? 32 : 16,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1440,
                  ),
                  child: _buildContent(desktop),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  final String value;
  final String label;
  final Color color;
  final IconData icon;
}











