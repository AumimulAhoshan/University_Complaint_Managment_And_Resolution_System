import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class ReportsAnalyticsScreen extends StatefulWidget {
  const ReportsAnalyticsScreen({super.key});

  @override
  State<ReportsAnalyticsScreen> createState() =>
      _ReportsAnalyticsScreenState();
}

class _ReportsAnalyticsScreenState
    extends State<ReportsAnalyticsScreen> {
  String _selectedPeriod = 'This Month';

  final List<_StatusData> _statusData = const [
    _StatusData(
      label: 'Submitted',
      value: 42,
      color: AppColors.submitted,
    ),
    _StatusData(
      label: 'Under Review',
      value: 38,
      color: AppColors.underReview,
    ),
    _StatusData(
      label: 'Assigned',
      value: 54,
      color: AppColors.assigned,
    ),
    _StatusData(
      label: 'In Progress',
      value: 67,
      color: AppColors.inProgress,
    ),
    _StatusData(
      label: 'Resolved',
      value: 312,
      color: AppColors.resolved,
    ),
    _StatusData(
      label: 'Closed',
      value: 96,
      color: AppColors.closed,
    ),
  ];

  final List<_PriorityData> _priorityData = const [
    _PriorityData(
      label: 'Low',
      value: 96,
      color: AppColors.lowPriority,
    ),
    _PriorityData(
      label: 'Medium',
      value: 184,
      color: AppColors.mediumPriority,
    ),
    _PriorityData(
      label: 'High',
      value: 143,
      color: AppColors.highPriority,
    ),
    _PriorityData(
      label: 'Urgent',
      value: 63,
      color: AppColors.urgentPriority,
    ),
  ];

  final List<_DepartmentData> _departmentData = const [
    _DepartmentData(
      name: 'CSE',
      total: 118,
      resolved: 84,
    ),
    _DepartmentData(
      name: 'EEE',
      total: 92,
      resolved: 63,
    ),
    _DepartmentData(
      name: 'BBA',
      total: 74,
      resolved: 51,
    ),
    _DepartmentData(
      name: 'English',
      total: 61,
      resolved: 43,
    ),
    _DepartmentData(
      name: 'Civil',
      total: 54,
      resolved: 37,
    ),
    _DepartmentData(
      name: 'Administration',
      total: 47,
      resolved: 34,
    ),
  ];

  final List<_CategoryData> _categoryData = const [
    _CategoryData(
      name: 'Internet & Network',
      complaints: 86,
    ),
    _CategoryData(
      name: 'Facilities',
      complaints: 72,
    ),
    _CategoryData(
      name: 'Student Services',
      complaints: 61,
    ),
    _CategoryData(
      name: 'Classroom',
      complaints: 54,
    ),
    _CategoryData(
      name: 'Laboratory',
      complaints: 48,
    ),
    _CategoryData(
      name: 'Library',
      complaints: 43,
    ),
  ];

  final List<_MonthlyData> _monthlyData = const [
    _MonthlyData(month: 'May', submitted: 74, resolved: 51),
    _MonthlyData(month: 'Jun', submitted: 86, resolved: 64),
    _MonthlyData(month: 'Jul', submitted: 92, resolved: 71),
    _MonthlyData(month: 'Aug', submitted: 105, resolved: 83),
    _MonthlyData(month: 'Sep', submitted: 98, resolved: 89),
    _MonthlyData(month: 'Oct', submitted: 84, resolved: 76),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPeriod,
                dropdownColor: AppColors.surface,
                iconEnabledColor: AppColors.darkTextPrimary,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'This Week',
                    child: Text('This Week'),
                  ),
                  DropdownMenuItem(
                    value: 'This Month',
                    child: Text('This Month'),
                  ),
                  DropdownMenuItem(
                    value: 'This Year',
                    child: Text('This Year'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _selectedPeriod = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 1024;

            return SingleChildScrollView(
              padding: EdgeInsets.all(isDesktop ? 24 : 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1440,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(isDesktop),
                      const SizedBox(height: 20),
                      _buildOverviewStats(isDesktop),
                      const SizedBox(height: 20),
                      _buildStatusAndPriority(isDesktop),
                      const SizedBox(height: 20),
                      _buildMonthlyTrend(),
                      const SizedBox(height: 20),
                      _buildDepartmentPerformance(),
                      const SizedBox(height: 20),
                      _buildCategoryPerformance(),
                      const SizedBox(height: 20),
                      _buildResolutionOverview(isDesktop),
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

  Widget _buildHeader(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 28 : 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
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
              color: AppColors.secondary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.analytics_outlined,
              color: AppColors.secondaryLight,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports & Analytics',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Monitor complaint trends, resolution performance, priorities, and department activity.',
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

  Widget _buildOverviewStats(bool isDesktop) {
    final stats = [
      _AnalyticsStat(
        title: 'Total Complaints',
        value: '486',
        subtitle: '+12.4% from last month',
        icon: Icons.assignment_outlined,
      ),
      _AnalyticsStat(
        title: 'Resolved',
        value: '312',
        subtitle: '64.2% resolution rate',
        icon: Icons.check_circle_outline_rounded,
      ),
      _AnalyticsStat(
        title: 'Pending',
        value: '84',
        subtitle: '17.3% of total',
        icon: Icons.pending_actions_rounded,
      ),
      _AnalyticsStat(
        title: 'Overdue',
        value: '23',
        subtitle: '4.7% of total',
        icon: Icons.warning_amber_rounded,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: stats
            .map(
              (stat) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildAnalyticsStat(stat),
            ),
          ),
        )
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
        MediaQuery.sizeOf(context).width >= 600 ? 2 : 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        return _buildAnalyticsStat(stats[index]);
      },
    );
  }

  Widget _buildAnalyticsStat(_AnalyticsStat stat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              stat.icon,
              color: AppColors.secondaryLight,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat.value,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 23,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stat.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.success,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusAndPriority(bool isDesktop) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildStatusCard()),
          const SizedBox(width: 16),
          Expanded(child: _buildPriorityCard()),
        ],
      );
    }

    return Column(
      children: [
        _buildStatusCard(),
        const SizedBox(height: 16),
        _buildPriorityCard(),
      ],
    );
  }

  Widget _buildStatusCard() {
    const total = 609;

    return _analyticsContainer(
      title: 'Complaint Status',
      icon: Icons.donut_large_rounded,
      child: Column(
        children: [
          ..._statusData.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _buildProgressRow(
                label: item.label,
                value: item.value,
                total: total,
                color: item.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityCard() {
    const total = 486;

    return _analyticsContainer(
      title: 'Priority Distribution',
      icon: Icons.priority_high_rounded,
      child: Column(
        children: [
          ..._priorityData.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _buildProgressRow(
                label: item.label,
                value: item.value,
                total: total,
                color: item.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow({
    required String label,
    required int value,
    required int total,
    required Color color,
  }) {
    final percentage = value / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 9,
              height: 9,
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
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 48,
              child: Text(
                '${(percentage * 100).round()}%',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextTertiary,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 7,
            backgroundColor: AppColors.darkBackgroundSecondary,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyTrend() {
    const maxValue = 120.0;

    return _analyticsContainer(
      title: 'Complaint Trend',
      icon: Icons.trending_up_rounded,
      subtitle: 'Submitted vs resolved complaints',
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _monthlyData.map((item) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildBar(
                                value: item.submitted,
                                maxValue: maxValue,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 5),
                              _buildBar(
                                value: item.resolved,
                                maxValue: maxValue,
                                color: AppColors.resolved,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.month,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(
                'Submitted',
                AppColors.secondary,
              ),
              const SizedBox(width: 24),
              _buildLegend(
                'Resolved',
                AppColors.resolved,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar({
    required int value,
    required double maxValue,
    required Color color,
  }) {
    return Flexible(
      child: FractionallySizedBox(
        heightFactor: value / maxValue,
        child: Container(
          width: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentPerformance() {
    return _analyticsContainer(
      title: 'Department Performance',
      icon: Icons.business_outlined,
      subtitle: 'Complaint volume and resolution performance',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Department',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Total',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Resolved',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Rate',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: AppColors.darkDivider),
          ..._departmentData.map(
                (department) => _buildDepartmentRow(department),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentRow(_DepartmentData department) {
    final rate = department.resolved / department.total;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              department.name,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${department.total}',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${department.resolved}',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.resolved,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${(rate * 100).round()}%',
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMedium.copyWith(
                color: rate >= 0.7
                    ? AppColors.success
                    : AppColors.warning,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPerformance() {
    final maxComplaints = _categoryData
        .map((category) => category.complaints)
        .reduce((a, b) => a > b ? a : b);

    return _analyticsContainer(
      title: 'Top Complaint Categories',
      icon: Icons.category_outlined,
      subtitle: 'Categories with the highest complaint volume',
      child: Column(
        children: _categoryData.map((category) {
          final percentage = category.complaints / maxComplaints;

          return Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.name,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.darkTextPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${category.complaints}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 9,
                    backgroundColor:
                    AppColors.darkBackgroundSecondary,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(
                      AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResolutionOverview(bool isDesktop) {
    final content = Row(
      children: [
        Expanded(
          child: _buildResolutionMetric(
            '64.2%',
            'Resolution Rate',
            Icons.check_circle_outline_rounded,
            AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildResolutionMetric(
            '2.8 Days',
            'Average Resolution',
            Icons.timer_outlined,
            AppColors.info,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildResolutionMetric(
            '4.7%',
            'Overdue Rate',
            Icons.warning_amber_rounded,
            AppColors.warning,
          ),
        ),
      ],
    );

    return _analyticsContainer(
      title: 'Resolution Overview',
      icon: Icons.speed_rounded,
      child: isDesktop
          ? content
          : Column(
        children: [
          _buildResolutionMetric(
            '64.2%',
            'Resolution Rate',
            Icons.check_circle_outline_rounded,
            AppColors.success,
          ),
          const SizedBox(height: 14),
          _buildResolutionMetric(
            '2.8 Days',
            'Average Resolution',
            Icons.timer_outlined,
            AppColors.info,
          ),
          const SizedBox(height: 14),
          _buildResolutionMetric(
            '4.7%',
            'Overdue Rate',
            Icons.warning_amber_rounded,
            AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildResolutionMetric(
      String value,
      String label,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkBackgroundSecondary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _analyticsContainer({
    required String title,
    required IconData icon,
    String? subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.secondaryLight,
                size: 23,
              ),
              const SizedBox(width: 10),
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
          if (subtitle != null) ...[
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextTertiary,
              ),
            ),
          ],
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _AnalyticsStat {
  const _AnalyticsStat({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
}

class _StatusData {
  const _StatusData({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;
}

class _PriorityData {
  const _PriorityData({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;
}

class _DepartmentData {
  const _DepartmentData({
    required this.name,
    required this.total,
    required this.resolved,
  });

  final String name;
  final int total;
  final int resolved;
}

class _CategoryData {
  const _CategoryData({
    required this.name,
    required this.complaints,
  });

  final String name;
  final int complaints;
}

class _MonthlyData {
  const _MonthlyData({
    required this.month,
    required this.submitted,
    required this.resolved,
  });

  final String month;
  final int submitted;
  final int resolved;
}