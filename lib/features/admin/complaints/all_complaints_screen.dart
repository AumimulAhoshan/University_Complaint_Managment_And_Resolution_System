import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class AllComplaintsScreen extends StatefulWidget {
  const AllComplaintsScreen({super.key});

  @override
  State<AllComplaintsScreen> createState() => _AllComplaintsScreenState();
}

class _AllComplaintsScreenState extends State<AllComplaintsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  String _selectedDepartment = 'All';

  final List<_AdminComplaint> _complaints = const [
    _AdminComplaint(
      number: 'CMP-2026-00486',
      title: 'Wi-Fi connection issue',
      student: 'Aumimul Ahosan',
      department: 'CSE',
      category: 'Internet & Network',
      status: 'In Progress',
      priority: 'High',
      date: '03 Oct 2026',
      assignedTo: 'Mahmud Ahmed',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00485',
      title: 'Classroom projector not working',
      student: 'Nusrat Jahan',
      department: 'EEE',
      category: 'Classroom',
      status: 'Under Review',
      priority: 'Medium',
      date: '03 Oct 2026',
      assignedTo: 'Unassigned',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00484',
      title: 'Library seat availability issue',
      student: 'Rakib Hasan',
      department: 'BBA',
      category: 'Library',
      status: 'Resolved',
      priority: 'Low',
      date: '02 Oct 2026',
      assignedTo: 'Sabbir Hossain',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00483',
      title: 'Student ID card problem',
      student: 'Sadia Islam',
      department: 'CSE',
      category: 'Student Services',
      status: 'Assigned',
      priority: 'Medium',
      date: '02 Oct 2026',
      assignedTo: 'Naim Rahman',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00482',
      title: 'Air conditioning problem',
      student: 'Tanvir Ahmed',
      department: 'English',
      category: 'Facilities',
      status: 'Submitted',
      priority: 'High',
      date: '02 Oct 2026',
      assignedTo: 'Unassigned',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00481',
      title: 'Lab computer not working',
      student: 'Fahim Rahman',
      department: 'CSE',
      category: 'Laboratory',
      status: 'In Progress',
      priority: 'Urgent',
      date: '01 Oct 2026',
      assignedTo: 'Mahmud Ahmed',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00480',
      title: 'Exam schedule clarification',
      student: 'Mim Akter',
      department: 'BBA',
      category: 'Academic',
      status: 'Closed',
      priority: 'Low',
      date: '01 Oct 2026',
      assignedTo: 'Nusrat Sultana',
    ),
    _AdminComplaint(
      number: 'CMP-2026-00479',
      title: 'Washroom maintenance issue',
      student: 'Shakil Khan',
      department: 'EEE',
      category: 'Facilities',
      status: 'Assigned',
      priority: 'High',
      date: '30 Sep 2026',
      assignedTo: 'Rashed Karim',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_AdminComplaint> get _filteredComplaints {
    final search = _searchController.text.trim().toLowerCase();

    return _complaints.where((complaint) {
      final matchesSearch =
          search.isEmpty ||
              complaint.number.toLowerCase().contains(search) ||
              complaint.title.toLowerCase().contains(search) ||
              complaint.student.toLowerCase().contains(search) ||
              complaint.department.toLowerCase().contains(search) ||
              complaint.category.toLowerCase().contains(search);

      final matchesStatus =
          _selectedStatus == 'All' ||
              complaint.status == _selectedStatus;

      final matchesPriority =
          _selectedPriority == 'All' ||
              complaint.priority == _selectedPriority;

      final matchesDepartment =
          _selectedDepartment == 'All' ||
              complaint.department == _selectedDepartment;

      return matchesSearch &&
          matchesStatus &&
          matchesPriority &&
          matchesDepartment;
    }).toList();
  }

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
          'All Complaints',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Dashboard',
            onPressed: () {
              context.go('/admin');
            },
            icon: const Icon(Icons.dashboard_outlined),
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
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchAndFilters(isDesktop, isTablet),
                  const SizedBox(height: 20),
                  _buildResultHeader(),
                  const SizedBox(height: 14),
                  _buildComplaints(isDesktop),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.report_problem_outlined,
              color: AppColors.primaryDark,
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complaint Management',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Review, monitor and manage all university complaints.',
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

  Widget _buildSearchAndFilters(bool isDesktop, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
            decoration: InputDecoration(
              hintText:
              'Search by complaint number, title, student or department...',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextTertiary,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.secondaryLight,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.clear_rounded,
                  color: AppColors.darkTextSecondary,
                ),
              )
                  : null,
              filled: true,
              fillColor: AppColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.secondary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (isDesktop || isTablet)
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: 'Status',
                    value: _selectedStatus,
                    items: const [
                      'All',
                      'Submitted',
                      'Under Review',
                      'Assigned',
                      'In Progress',
                      'Resolved',
                      'Closed',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Priority',
                    value: _selectedPriority,
                    items: const [
                      'All',
                      'Low',
                      'Medium',
                      'High',
                      'Urgent',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Department',
                    value: _selectedDepartment,
                    items: const [
                      'All',
                      'CSE',
                      'EEE',
                      'BBA',
                      'English',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedDepartment = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                _buildResetButton(),
              ],
            )
          else
            Column(
              children: [
                _buildDropdown(
                  label: 'Status',
                  value: _selectedStatus,
                  items: const [
                    'All',
                    'Submitted',
                    'Under Review',
                    'Assigned',
                    'In Progress',
                    'Resolved',
                    'Closed',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  label: 'Priority',
                  value: _selectedPriority,
                  items: const [
                    'All',
                    'Low',
                    'Medium',
                    'High',
                    'Urgent',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  label: 'Department',
                  value: _selectedDepartment,
                  items: const [
                    'All',
                    'CSE',
                    'EEE',
                    'BBA',
                    'English',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedDepartment = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: _buildResetButton(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      dropdownColor: AppColors.surface,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textOnPrimary,
      ),
      iconEnabledColor: AppColors.secondaryLight,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 1.5,
          ),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  Widget _buildResetButton() {
    return OutlinedButton.icon(
      onPressed: _resetFilters,
      icon: const Icon(Icons.refresh_rounded, size: 18),
      label: const Text('Reset'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondaryLight,
        side: BorderSide(
          color: AppColors.secondary.withValues(alpha: 0.6),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildResultHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${_filteredComplaints.length} complaints found',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (_hasActiveFilters)
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Clear filters',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.secondaryLight,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildComplaints(bool isDesktop) {
    final complaints = _filteredComplaints;

    if (complaints.isEmpty) {
      return _buildEmptyState();
    }

    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: complaints.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.65,
        ),
        itemBuilder: (context, index) {
          return _buildComplaintCard(complaints[index]);
        },
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: complaints.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildComplaintCard(complaints[index]);
      },
    );
  }

  Widget _buildComplaintCard(_AdminComplaint complaint) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () {
          context.go(
            '/admin/complaint-details?number=${Uri.encodeComponent(complaint.number)}',
          );
        },
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
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
                          complaint.number,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.secondaryLight,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          complaint.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.darkTextTertiary,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                Icons.person_outline_rounded,
                complaint.student,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.school_outlined,
                '${complaint.department} • ${complaint.category}',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.person_pin_outlined,
                'Assigned: ${complaint.assignedTo}',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.calendar_today_outlined,
                complaint.date,
              ),
              const Spacer(),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildBadge(
                    complaint.status,
                    _statusColor(complaint.status),
                  ),
                  const SizedBox(width: 8),
                  _buildBadge(
                    complaint.priority,
                    _priorityColor(complaint.priority),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.darkTextTertiary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ],
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

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: AppColors.darkTextTertiary,
              size: 34,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No complaints found',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 18),
          _buildResetButton(),
        ],
      ),
    );
  }

  void _resetFilters() {
    _searchController.clear();

    setState(() {
      _selectedStatus = 'All';
      _selectedPriority = 'All';
      _selectedDepartment = 'All';
    });
  }

  bool get _hasActiveFilters {
    return _searchController.text.isNotEmpty ||
        _selectedStatus != 'All' ||
        _selectedPriority != 'All' ||
        _selectedDepartment != 'All';
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

class _AdminComplaint {
  final String number;
  final String title;
  final String student;
  final String department;
  final String category;
  final String status;
  final String priority;
  final String date;
  final String assignedTo;

  const _AdminComplaint({
    required this.number,
    required this.title,
    required this.student,
    required this.department,
    required this.category,
    required this.status,
    required this.priority,
    required this.date,
    required this.assignedTo,
  });
}