import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<_AdminStat> _stats = const [
    _AdminStat(
      title: 'Total Users',
      value: '1,248',
      subtitle: 'Registered users',
      icon: Icons.people_alt_outlined,
    ),
    _AdminStat(
      title: 'Students',
      value: '1,086',
      subtitle: 'Active students',
      icon: Icons.school_outlined,
    ),
    _AdminStat(
      title: 'Staff',
      value: '162',
      subtitle: 'Active staff',
      icon: Icons.badge_outlined,
    ),
    _AdminStat(
      title: 'Complaints',
      value: '486',
      subtitle: 'Total complaints',
      icon: Icons.report_problem_outlined,
    ),
    _AdminStat(
      title: 'Pending',
      value: '84',
      subtitle: 'Need attention',
      icon: Icons.pending_actions_outlined,
    ),
    _AdminStat(
      title: 'In Progress',
      value: '67',
      subtitle: 'Currently working',
      icon: Icons.sync_outlined,
    ),
    _AdminStat(
      title: 'Resolved',
      value: '312',
      subtitle: 'Successfully resolved',
      icon: Icons.check_circle_outline,
    ),
    _AdminStat(
      title: 'Overdue',
      value: '23',
      subtitle: 'Past due date',
      icon: Icons.warning_amber_outlined,
    ),
  ];

  final List<_RecentComplaint> _recentComplaints = const [
    _RecentComplaint(
      number: 'CMP-2026-00486',
      title: 'Wi-Fi connection issue',
      student: 'Aumimul Ahosan',
      department: 'CSE',
      status: 'In Progress',
      priority: 'High',
    ),
    _RecentComplaint(
      number: 'CMP-2026-00485',
      title: 'Classroom projector not working',
      student: 'Nusrat Jahan',
      department: 'EEE',
      status: 'Under Review',
      priority: 'Medium',
    ),
    _RecentComplaint(
      number: 'CMP-2026-00484',
      title: 'Library seat availability issue',
      student: 'Rakib Hasan',
      department: 'BBA',
      status: 'Resolved',
      priority: 'Low',
    ),
    _RecentComplaint(
      number: 'CMP-2026-00483',
      title: 'Student ID card problem',
      student: 'Sadia Islam',
      department: 'CSE',
      status: 'Assigned',
      priority: 'Medium',
    ),
  ];

  final List<_DepartmentStat> _departments = const [
    _DepartmentStat(
      name: 'Computer Science',
      complaints: 126,
      resolved: 94,
    ),
    _DepartmentStat(
      name: 'Electrical Engineering',
      complaints: 98,
      resolved: 71,
    ),
    _DepartmentStat(
      name: 'Business Administration',
      complaints: 82,
      resolved: 63,
    ),
    _DepartmentStat(
      name: 'English',
      complaints: 64,
      resolved: 51,
    ),
  ];

  final List<_ActivityItem> _activities = const [
    _ActivityItem(
      title: 'New complaint submitted',
      description: 'CMP-2026-00486 was submitted by Aumimul Ahosan.',
      time: '10 min ago',
      icon: Icons.add_task_outlined,
    ),
    _ActivityItem(
      title: 'Complaint resolved',
      description: 'CMP-2026-00484 was marked as resolved.',
      time: '32 min ago',
      icon: Icons.check_circle_outline,
    ),
    _ActivityItem(
      title: 'New staff account created',
      description: 'A new staff member was added to IT Support.',
      time: '1 hour ago',
      icon: Icons.person_add_alt_outlined,
    ),
    _ActivityItem(
      title: 'Category updated',
      description: 'The Internet & Network category was updated.',
      time: '2 hours ago',
      icon: Icons.category_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              context.go('/admin/notifications');
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              context.go('/admin/profile');
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 32 : 16,
            20,
            isDesktop ? 32 : 16,
            32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(isDesktop),
                  const SizedBox(height: 24),
                  _buildStatsGrid(isDesktop, isTablet),
                  const SizedBox(height: 24),
                  if (isDesktop)
                    _buildDesktopContent()
                  else
                    _buildMobileContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 28 : 22),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
            width: isDesktop ? 68 : 56,
            height: isDesktop ? 68 : 56,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.admin_panel_settings_outlined,
              color: AppColors.primaryDark,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Admin',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Monitor university services, complaints and system activity.',
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

  Widget _buildStatsGrid(bool isDesktop, bool isTablet) {
    int columns;

    if (isDesktop) {
      columns = 4;
    } else if (isTablet) {
      columns = 2;
    } else {
      columns = 2;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: isDesktop ? 1.65 : 1.35,
      ),
      itemBuilder: (context, index) {
        return _buildStatCard(_stats[index]);
      },
    );
  }

  Widget _buildStatCard(_AdminStat stat) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.7),
        ),
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
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  stat.icon,
                  color: AppColors.primaryDark,
                  size: 21,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz_rounded,
                color: AppColors.darkTextTertiary,
              ),
            ],
          ),
          const Spacer(),
          Text(
            stat.value,
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildStatusOverview(),
              const SizedBox(height: 24),
              _buildRecentComplaints(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildDepartmentOverview(),
              const SizedBox(height: 24),
              _buildRecentActivity(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      children: [
        _buildQuickActions(),
        const SizedBox(height: 24),
        _buildStatusOverview(),
        const SizedBox(height: 24),
        _buildRecentComplaints(),
        const SizedBox(height: 24),
        _buildDepartmentOverview(),
        const SizedBox(height: 24),
        _buildRecentActivity(),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return _buildSectionCard(
      title: 'Quick Actions',
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.45,
        children: [
          _buildActionButton(
            icon: Icons.report_problem_outlined,
            title: 'All Complaints',
            onTap: () {
              context.go('/admin/complaints');
            },
          ),
          _buildActionButton(
            icon: Icons.people_outline_rounded,
            title: 'Users',
            onTap: () {
              context.go('/admin/users');
            },
          ),
          _buildActionButton(
            icon: Icons.badge_outlined,
            title: 'Staff',
            onTap: () {
              context.go('/admin/staff');
            },
          ),
          _buildActionButton(
            icon: Icons.bar_chart_rounded,
            title: 'Reports',
            onTap: () {
              context.go('/admin/reports');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.secondaryLight,
                size: 26,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusOverview() {
    return _buildSectionCard(
      title: 'Complaint Status Overview',
      trailing: TextButton(
        onPressed: () {
          context.go('/admin/complaints');
        },
        child: Text(
          'View All',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.secondaryLight,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildStatusRow(
            label: 'Submitted',
            value: 48,
            total: 486,
            color: AppColors.submitted,
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            label: 'Under Review',
            value: 84,
            total: 486,
            color: AppColors.underReview,
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            label: 'Assigned',
            value: 57,
            total: 486,
            color: AppColors.assigned,
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            label: 'In Progress',
            value: 67,
            total: 486,
            color: AppColors.inProgress,
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            label: 'Resolved',
            value: 207,
            total: 486,
            color: AppColors.resolved,
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            label: 'Closed',
            value: 23,
            total: 486,
            color: AppColors.closed,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow({
    required String label,
    required int value,
    required int total,
    required Color color,
  }) {
    final progress = value / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
            Text(
              '$value',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: AppColors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentComplaints() {
    return _buildSectionCard(
      title: 'Recent Complaints',
      trailing: TextButton(
        onPressed: () {
          context.go('/admin/complaints');
        },
        child: Text(
          'View All',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.secondaryLight,
          ),
        ),
      ),
      child: Column(
        children: List.generate(
          _recentComplaints.length,
              (index) {
            final complaint = _recentComplaints[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _recentComplaints.length - 1 ? 0 : 12,
              ),
              child: _buildComplaintTile(complaint),
            );
          },
        ),
      ),
    );
  }

  Widget _buildComplaintTile(_RecentComplaint complaint) {
    return Material(
      color: AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          context.go(
            '/admin/complaint-details?number=${Uri.encodeComponent(complaint.number)}',
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.primaryDark,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      complaint.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${complaint.number} • ${complaint.student}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextTertiary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildBadge(
                          complaint.status,
                          _statusColor(complaint.status),
                        ),
                        _buildBadge(
                          complaint.priority,
                          _priorityColor(complaint.priority),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.darkTextTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildDepartmentOverview() {
    return _buildSectionCard(
      title: 'Department Overview',
      trailing: TextButton(
        onPressed: () {
          context.go('/admin/departments');
        },
        child: Text(
          'Manage',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.secondaryLight,
          ),
        ),
      ),
      child: Column(
        children: List.generate(
          _departments.length,
              (index) {
            final department = _departments[index];
            final percentage = department.resolved / department.complaints;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _departments.length - 1 ? 0 : 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          department.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${department.complaints} complaints',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.darkTextTertiary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 7,
                      backgroundColor: AppColors.surfaceVariant,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${department.resolved} resolved • ${(percentage * 100).round()}% resolution rate',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.darkTextTertiary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return _buildSectionCard(
      title: 'Recent Activity',
      child: Column(
        children: List.generate(
          _activities.length,
              (index) {
            final activity = _activities[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _activities.length - 1 ? 0 : 18,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      activity.icon,
                      color: AppColors.primaryDark,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          activity.description,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          activity.time,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextTertiary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Submitted':
        return AppColors.submitted;
      case 'Under Review':
        return AppColors.underReview;
      case 'Assigned':
        return AppColors.assigned;
      case 'In Progress':
        return AppColors.inProgress;
      case 'Resolved':
        return AppColors.resolved;
      case 'Closed':
        return AppColors.closed;
      default:
        return AppColors.darkTextSecondary;
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Low':
        return AppColors.lowPriority;
      case 'Medium':
        return AppColors.mediumPriority;
      case 'High':
        return AppColors.highPriority;
      case 'Urgent':
        return AppColors.urgentPriority;
      default:
        return AppColors.darkTextSecondary;
    }
  }
}

class _AdminStat {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const _AdminStat({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });
}

class _RecentComplaint {
  final String number;
  final String title;
  final String student;
  final String department;
  final String status;
  final String priority;

  const _RecentComplaint({
    required this.number,
    required this.title,
    required this.student,
    required this.department,
    required this.status,
    required this.priority,
  });
}

class _DepartmentStat {
  final String name;
  final int complaints;
  final int resolved;

  const _DepartmentStat({
    required this.name,
    required this.complaints,
    required this.resolved,
  });
}

class _ActivityItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;

  const _ActivityItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });
}