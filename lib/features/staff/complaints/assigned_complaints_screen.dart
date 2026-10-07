import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class AssignedComplaintsScreen extends StatefulWidget {
  final String? initialStatus;

  const AssignedComplaintsScreen({
    super.key,
    this.initialStatus,
  });

  @override
  State<AssignedComplaintsScreen> createState() =>
      _AssignedComplaintsScreenState();
}

class _AssignedComplaintsScreenState
    extends State<AssignedComplaintsScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  String _selectedCategory = 'All';

  final List<_StaffComplaint> _complaints = [
    _StaffComplaint(
      number: '#CMP-1024',
      title: 'Classroom projector not working',
      category: 'IT & Equipment',
      department: 'Computer Science',
      location: 'Academic Building - Room 302',
      date: 'Oct 02, 2026',
      status: 'In Progress',
      priority: 'High',
    ),
    _StaffComplaint(
      number: '#CMP-1021',
      title: 'Air conditioning issue',
      category: 'Facilities',
      department: 'Business Administration',
      location: 'Academic Building - Room 204',
      date: 'Oct 02, 2026',
      status: 'Assigned',
      priority: 'Medium',
    ),
    _StaffComplaint(
      number: '#CMP-1018',
      title: 'Laboratory computer problem',
      category: 'IT & Equipment',
      department: 'Electrical Engineering',
      location: 'Engineering Lab - Lab 2',
      date: 'Oct 01, 2026',
      status: 'In Progress',
      priority: 'Urgent',
    ),
    _StaffComplaint(
      number: '#CMP-1015',
      title: 'Broken classroom chair',
      category: 'Facilities',
      department: 'English',
      location: 'Humanities Building - Room 105',
      date: 'Sep 30, 2026',
      status: 'Assigned',
      priority: 'Low',
    ),
    _StaffComplaint(
      number: '#CMP-1012',
      title: 'Wi-Fi connection problem',
      category: 'Network',
      department: 'Computer Science',
      location: 'Library - 2nd Floor',
      date: 'Sep 29, 2026',
      status: 'Resolved',
      priority: 'Medium',
    ),
    _StaffComplaint(
      number: '#CMP-1009',
      title: 'Projector display issue',
      category: 'IT & Equipment',
      department: 'Architecture',
      location: 'Design Studio - Room 401',
      date: 'Sep 28, 2026',
      status: 'In Progress',
      priority: 'High',
    ),
    _StaffComplaint(
      number: '#CMP-1005',
      title: 'Water dispenser not working',
      category: 'Facilities',
      department: 'Law',
      location: 'Main Building - 1st Floor',
      date: 'Sep 27, 2026',
      status: 'Resolved',
      priority: 'Low',
    ),
    _StaffComplaint(
      number: '#CMP-1001',
      title: 'Computer lab network outage',
      category: 'Network',
      department: 'Computer Science',
      location: 'Computer Lab - Lab 1',
      date: 'Sep 26, 2026',
      status: 'Assigned',
      priority: 'Urgent',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchChanged);

    if (widget.initialStatus == 'in-progress') {
      _selectedStatus = 'In Progress';
    }
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();

    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _handleBack() {
    // IMPORTANT:
    // This screen was opened with context.push() from the
    // Staff Dashboard, so pop() returns to that Dashboard.
    if (context.canPop()) {
      context.pop();
    } else {
      // Safety fallback if this screen was opened directly.
      context.go('/staff');
    }
  }

  List<_StaffComplaint> get _filteredComplaints {
    final query = _searchController.text.trim().toLowerCase();

    return _complaints.where((complaint) {
      final matchesSearch = query.isEmpty ||
          complaint.number.toLowerCase().contains(query) ||
          complaint.title.toLowerCase().contains(query) ||
          complaint.category.toLowerCase().contains(query) ||
          complaint.department.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == 'All' ||
          complaint.status == _selectedStatus;

      final matchesPriority = _selectedPriority == 'All' ||
          complaint.priority == _selectedPriority;

      final matchesCategory = _selectedCategory == 'All' ||
          complaint.category == _selectedCategory;

      return matchesSearch &&
          matchesStatus &&
          matchesPriority &&
          matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final complaints = _filteredComplaints;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        elevation: 0,

        // THIS IS THE IMPORTANT BACK BUTTON.
        leading: IconButton(
          tooltip: 'Back to Dashboard',
          onPressed: _handleBack,
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),

        title: const Text(
          'Manage Assigned Complaints',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            Responsive.horizontalPadding(context),
            16,
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
                  _buildPageHeader(),
                  const SizedBox(height: 20),
                  _buildSearchAndFilters(),
                  const SizedBox(height: 20),
                  _buildResultsHeader(complaints.length),
                  const SizedBox(height: 12),
                  if (complaints.isEmpty)
                    _buildEmptyState()
                  else
                    _buildComplaintList(complaints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.assignment_outlined,
              color: AppColors.primarySurface,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Assigned Complaints',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Review complaints assigned to you, track progress, and take the necessary actions.',
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

  Widget _buildSearchAndFilters() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            style: const TextStyle(
              color: AppColors.white,
            ),
            cursorColor: AppColors.primarySurface,
            decoration: InputDecoration(
              hintText: 'Search complaints...',
              hintStyle: const TextStyle(
                color: AppColors.darkTextTertiary,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.darkTextSecondary,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(
                  Icons.clear_rounded,
                ),
              )
                  : null,
            ),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 650;

              if (isSmall) {
                return Column(
                  children: [
                    _buildFilter(
                      label: 'Status',
                      value: _selectedStatus,
                      items: const [
                        'All',
                        'Assigned',
                        'In Progress',
                        'Resolved',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildFilter(
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
                    _buildFilter(
                      label: 'Category',
                      value: _selectedCategory,
                      items: const [
                        'All',
                        'IT & Equipment',
                        'Facilities',
                        'Network',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildFilter(
                      label: 'Status',
                      value: _selectedStatus,
                      items: const [
                        'All',
                        'Assigned',
                        'In Progress',
                        'Resolved',
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
                    child: _buildFilter(
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
                    child: _buildFilter(
                      label: 'Category',
                      value: _selectedCategory,
                      items: const [
                        'All',
                        'IT & Equipment',
                        'Facilities',
                        'Network',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
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

  Widget _buildFilter({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      dropdownColor: AppColors.surface,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 13,
      ),
      decoration: InputDecoration(
        labelText: label,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ),
      )
          .toList(),
    );
  }

  Widget _buildResultsHeader(int count) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Complaint List',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          '$count complaint${count == 1 ? '' : 's'}',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.darkTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildComplaintList(
      List<_StaffComplaint> complaints,
      ) {
    return Column(
      children: complaints
          .map(
            (complaint) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildComplaintCard(complaint),
        ),
      )
          .toList(),
    );
  }

  Widget _buildComplaintCard(
      _StaffComplaint complaint,
      ) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),

        // IMPORTANT:
        // Push the details page so this page remains in
        // the navigation stack.
        onTap: () {
          context.push(
            '/staff/complaint-details?number=${Uri.encodeComponent(complaint.number)}',
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(18),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 650;

              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildComplaintMainInfo(complaint),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildStatusBadge(
                          complaint.status,
                          _statusColor(complaint.status),
                        ),
                        _buildPriorityBadge(
                          complaint.priority,
                        ),
                      ],
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildComplaintMainInfo(complaint),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildStatusBadge(
                        complaint.status,
                        _statusColor(complaint.status),
                      ),
                      const SizedBox(height: 8),
                      _buildPriorityBadge(
                        complaint.priority,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintMainInfo(
      _StaffComplaint complaint,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                complaint.number,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primarySurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                complaint.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                complaint.category,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.darkTextSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${complaint.department} • ${complaint.location}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.darkTextTertiary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                complaint.date,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.darkTextTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(
      String status,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
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

  Widget _buildPriorityBadge(String priority) {
    final color = _priorityColor(priority);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
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
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: AppColors.primarySurface,
              size: 32,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No complaints found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.darkTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Assigned':
        return AppColors.assigned;
      case 'In Progress':
        return AppColors.inProgress;
      case 'Resolved':
        return AppColors.success;
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

class _StaffComplaint {
  final String number;
  final String title;
  final String category;
  final String department;
  final String location;
  final String date;
  final String status;
  final String priority;

  const _StaffComplaint({
    required this.number,
    required this.title,
    required this.category,
    required this.department,
    required this.location,
    required this.date,
    required this.status,
    required this.priority,
  });
}