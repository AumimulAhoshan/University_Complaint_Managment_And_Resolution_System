import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'UniServa',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/student/notifications');
            },
            tooltip: 'Notifications',
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              context.push('/student/profile');
            },
            tooltip: 'Profile',
            icon: const Icon(
              Icons.person_outline_rounded,
            ),
          ),
          const SizedBox(width: 4),
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
                maxWidth: 1200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeCard(context),
                  const SizedBox(height: 20),
                  _buildStatsSection(),
                  const SizedBox(height: 20),
                  _buildQuickActions(context),
                  const SizedBox(height: 24),
                  _buildRecentComplaintsHeader(context),
                  const SizedBox(height: 12),
                  _buildRecentComplaints(context),
                  const SizedBox(height: 20),
                  _buildHelpCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // WELCOME CARD
  // ---------------------------------------------------------------------------

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: 0.12,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Responsive.isMobile(context)
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeText(),
          const SizedBox(height: 22),
          _buildSubmitButton(context),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: _buildWelcomeText(),
          ),
          const SizedBox(width: 24),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.waving_hand_rounded,
                color: AppColors.primarySurface,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            const Text(
              'Hello, Student!',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Have a problem at your university?',
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Submit a complaint and track its progress until it is resolved.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkTextSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
      BuildContext context,
      ) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          context.push(
            '/student/submit-complaint',
          );
        },
        icon: const Icon(
          Icons.add_rounded,
        ),
        label: const Text(
          'Submit Complaint',
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.resolved,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STATISTICS
  // ---------------------------------------------------------------------------

  Widget _buildStatsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= 800) {
          return Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.assignment_outlined,
                  title: 'Total',
                  value: '12',
                  iconColor: AppColors.primarySurface,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.pending_actions_rounded,
                  title: 'Pending',
                  value: '03',
                  iconColor: AppColors.warning,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.sync_rounded,
                  title: 'In Progress',
                  value: '04',
                  iconColor: AppColors.info,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.check_circle_outline_rounded,
                  title: 'Resolved',
                  value: '05',
                  iconColor: AppColors.success,
                ),
              ),
            ],
          );
        }

        return GridView.count(
          crossAxisCount: width < 500 ? 2 : 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: width < 500 ? 1.35 : 1.15,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStatCard(
              icon: Icons.assignment_outlined,
              title: 'Total',
              value: '12',
              iconColor: AppColors.primarySurface,
            ),
            _buildStatCard(
              icon: Icons.pending_actions_rounded,
              title: 'Pending',
              value: '03',
              iconColor: AppColors.warning,
            ),
            _buildStatCard(
              icon: Icons.sync_rounded,
              title: 'In Progress',
              value: '04',
              iconColor: AppColors.info,
            ),
            _buildStatCard(
              icon: Icons.check_circle_outline_rounded,
              title: 'Resolved',
              value: '05',
              iconColor: AppColors.success,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: 0.08,
            ),
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
              icon,
              color: iconColor,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
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

  // ---------------------------------------------------------------------------
  // QUICK ACTIONS
  // ---------------------------------------------------------------------------

  Widget _buildQuickActions(
      BuildContext context,
      ) {
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
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 520;

              if (isSmall) {
                return Column(
                  children: [
                    _buildActionTile(
                      icon: Icons.add_circle_outline_rounded,
                      title: 'Submit Complaint',
                      subtitle: 'Report a new problem',
                      onTap: () {
                        context.push(
                          '/student/submit-complaint',
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildActionTile(
                      icon: Icons.assignment_outlined,
                      title: 'My Complaints',
                      subtitle: 'View all your complaints',
                      onTap: () {
                        context.push(
                          '/student/my-complaints',
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildActionTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      subtitle: 'Check latest updates',
                      onTap: () {
                        context.push(
                          '/student/notifications',
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildActionTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Profile',
                      subtitle: 'View and manage your profile',
                      onTap: () {
                        context.push(
                          '/student/profile',
                        );
                      },
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.add_circle_outline_rounded,
                      title: 'Submit Complaint',
                      subtitle: 'Report a new problem',
                      onTap: () {
                        context.push(
                          '/student/submit-complaint',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.assignment_outlined,
                      title: 'My Complaints',
                      subtitle: 'View all your complaints',
                      onTap: () {
                        context.push(
                          '/student/my-complaints',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      subtitle: 'Check latest updates',
                      onTap: () {
                        context.push(
                          '/student/notifications',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Profile',
                      subtitle: 'View and manage your profile',
                      onTap: () {
                        context.push(
                          '/student/profile',
                        );
                      },
                    ),
                  ),
                ],
              );
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
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

  // ---------------------------------------------------------------------------
  // RECENT COMPLAINTS
  // ---------------------------------------------------------------------------

  Widget _buildRecentComplaintsHeader(
      BuildContext context,
      ) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Recent Complaints',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.push(
              '/student/my-complaints',
            );
          },
          child: const Text(
            'View All',
          ),
        ),
      ],
    );
  }

  Widget _buildRecentComplaints(
      BuildContext context,
      ) {
    final complaints = [
      _ComplaintItem(
        number: '#US-1003',
        title: 'Classroom Projector Not Working',
        category: 'IT & Equipment',
        status: 'In Progress',
        statusColor: AppColors.info,
        date: 'Oct 02, 2026',
      ),
      _ComplaintItem(
        number: '#US-1002',
        title: 'Washroom Maintenance Required',
        category: 'Maintenance',
        status: 'Pending',
        statusColor: AppColors.warning,
        date: 'Oct 01, 2026',
      ),
      _ComplaintItem(
        number: '#US-1001',
        title: 'Library AC Problem',
        category: 'Facilities',
        status: 'Resolved',
        statusColor: AppColors.success,
        date: 'Sep 29, 2026',
      ),
    ];

    return Column(
      children: complaints.map((complaint) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
          ),
          child: _buildComplaintItem(
            complaint,
            context,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildComplaintItem(
      _ComplaintItem complaint,
      BuildContext context,
      ) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          context.push(
            '/student/complaint-details?number=${Uri.encodeComponent(complaint.number)}',
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.primarySurface,
                  size: 23,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      complaint.number,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      complaint.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            complaint.category,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Text(
                          '•',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          complaint.date,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
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
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.14,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELP CARD
  // ---------------------------------------------------------------------------

  Widget _buildHelpCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              color: AppColors.primarySurface,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Need help?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'You can track your complaint status anytime from My Complaints.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                    height: 1.4,
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

// -----------------------------------------------------------------------------
// RECENT COMPLAINT MODEL
// -----------------------------------------------------------------------------

class _ComplaintItem {
  final String number;
  final String title;
  final String category;
  final String status;
  final Color statusColor;
  final String date;

  const _ComplaintItem({
    required this.number,
    required this.title,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.date,
  });
}