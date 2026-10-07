import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Staff Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/staff/notifications');
            },
            tooltip: 'Notifications',
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              context.push('/staff/profile');
            },
            tooltip: 'Profile',
            icon: const Icon(
              Icons.person_outline_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            Responsive.horizontalPadding(context),
            12,
            Responsive.horizontalPadding(context),
            32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1440,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeCard(),
                  const SizedBox(height: 20),
                  _buildStatsSection(context),
                  const SizedBox(height: 20),
                  _buildMainContent(context),
                  const SizedBox(height: 20),
                  _buildWorkSummary(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.primarySurface,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back, Staff!',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Manage assigned complaints, track progress, and help resolve university issues.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final cards = [
      _StatData(
        icon: Icons.assignment_outlined,
        title: 'Assigned',
        value: '18',
        color: AppColors.primarySurface,
      ),
      _StatData(
        icon: Icons.sync_rounded,
        title: 'In Progress',
        value: '07',
        color: AppColors.info,
      ),
      _StatData(
        icon: Icons.check_circle_outline_rounded,
        title: 'Resolved',
        value: '32',
        color: AppColors.success,
      ),
      _StatData(
        icon: Icons.warning_amber_rounded,
        title: 'Overdue',
        value: '03',
        color: AppColors.error,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 600) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildStatCard(cards[0])),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard(cards[1])),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildStatCard(cards[2])),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard(cards[3])),
                ],
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: _buildStatCard(cards[0])),
            const SizedBox(width: 14),
            Expanded(child: _buildStatCard(cards[1])),
            const SizedBox(width: 14),
            Expanded(child: _buildStatCard(cards[2])),
            const SizedBox(width: 14),
            Expanded(child: _buildStatCard(cards[3])),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(_StatData data) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              data.icon,
              color: data.color,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1000;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildQuickActions(context),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildRecentComplaints(context),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildQuickActions(context),
            const SizedBox(height: 20),
            _buildRecentComplaints(context),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 14),

          // ASSIGNED COMPLAINTS
          _buildActionTile(
            icon: Icons.assignment_outlined,
            title: 'Assigned Complaints',
            subtitle: 'View all complaints assigned to you',
            onTap: () {
              context.push('/staff/complaints');
            },
          ),

          const SizedBox(height: 10),

          // IN PROGRESS
          _buildActionTile(
            icon: Icons.sync_rounded,
            title: 'In Progress',
            subtitle: 'View complaints currently being handled',
            onTap: () {
              context.push(
                '/staff/complaints?status=in-progress',
              );
            },
          ),

          const SizedBox(height: 10),

          // NOTIFICATIONS
          _buildActionTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'Check latest updates',
            onTap: () {
              context.push('/staff/notifications');
            },
          ),

          const SizedBox(height: 10),

          // PROFILE
          _buildActionTile(
            icon: Icons.person_outline_rounded,
            title: 'My Profile',
            subtitle: 'View and manage your profile',
            onTap: () {
              context.push('/staff/profile');
            },
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
  }) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primarySurface,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.darkTextTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentComplaints(BuildContext context) {
    final complaints = [
      _RecentComplaint(
        number: '#CMP-1024',
        title: 'Classroom projector not working',
        category: 'IT & Equipment',
        status: 'In Progress',
        statusColor: AppColors.info,
      ),
      _RecentComplaint(
        number: '#CMP-1021',
        title: 'Air conditioning issue',
        category: 'Facilities',
        status: 'Assigned',
        statusColor: AppColors.assigned,
      ),
      _RecentComplaint(
        number: '#CMP-1018',
        title: 'Laboratory computer problem',
        category: 'IT & Equipment',
        status: 'In Progress',
        statusColor: AppColors.info,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Recent Assigned Complaints',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/staff/complaints');
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...complaints.map(
                (complaint) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildRecentComplaintTile(
                context,
                complaint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentComplaintTile(
      BuildContext context,
      _RecentComplaint complaint,
      ) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          context.push(
            '/staff/complaint-details?number=${Uri.encodeComponent(complaint.number)}',
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.primarySurface,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      complaint.number,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primarySurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      complaint.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      complaint.category,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildStatusBadge(
                complaint.status,
                complaint.statusColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
      String status,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildWorkSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.insights_rounded,
              color: AppColors.primarySurface,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Work Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Keep track of your assigned complaints and resolve issues within the expected time.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatData {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatData({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });
}

class _RecentComplaint {
  final String number;
  final String title;
  final String category;
  final String status;
  final Color statusColor;

  const _RecentComplaint({
    required this.number,
    required this.title,
    required this.category,
    required this.status,
    required this.statusColor,
  });
}