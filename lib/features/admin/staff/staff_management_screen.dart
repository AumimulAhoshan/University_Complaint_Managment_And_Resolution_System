import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() =>
      _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedDepartment = 'All';
  String _selectedStatus = 'All';

  final List<_StaffData> _staffMembers = [
    _StaffData(
      name: 'Mahmud Ahmed',
      email: 'mahmud@uniserva.edu',
      staffId: 'STF-2021-017',
      department: 'Information Technology',
      designation: 'IT Support Officer',
      phone: '+880 1712-789012',
      status: 'Active',
      joinedDate: '12 Jan 2021',
      assignedComplaints: 18,
    ),
    _StaffData(
      name: 'Sabbir Hossain',
      email: 'sabbir@uniserva.edu',
      staffId: 'STF-2022-024',
      department: 'Library',
      designation: 'Senior Librarian',
      phone: '+880 1812-890123',
      status: 'Active',
      joinedDate: '08 Mar 2022',
      assignedComplaints: 12,
    ),
    _StaffData(
      name: 'Naim Rahman',
      email: 'naim@uniserva.edu',
      staffId: 'STF-2020-011',
      department: 'Student Services',
      designation: 'Student Affairs Officer',
      phone: '+880 1912-901234',
      status: 'Inactive',
      joinedDate: '21 Sep 2020',
      assignedComplaints: 7,
    ),
    _StaffData(
      name: 'Rashed Karim',
      email: 'rashed@uniserva.edu',
      staffId: 'STF-2023-031',
      department: 'Facilities',
      designation: 'Facilities Supervisor',
      phone: '+880 1612-345678',
      status: 'Active',
      joinedDate: '17 Jul 2023',
      assignedComplaints: 15,
    ),
    _StaffData(
      name: 'Nusrat Sultana',
      email: 'nusrat@uniserva.edu',
      staffId: 'STF-2022-019',
      department: 'Academic Affairs',
      designation: 'Academic Officer',
      phone: '+880 1712-456789',
      status: 'Active',
      joinedDate: '05 Feb 2022',
      assignedComplaints: 10,
    ),
    _StaffData(
      name: 'Farhan Ahmed',
      email: 'farhan@uniserva.edu',
      staffId: 'STF-2024-042',
      department: 'Information Technology',
      designation: 'System Administrator',
      phone: '+880 1812-567890',
      status: 'Active',
      joinedDate: '11 Apr 2024',
      assignedComplaints: 9,
    ),
    _StaffData(
      name: 'Shamim Hasan',
      email: 'shamim@uniserva.edu',
      staffId: 'STF-2021-028',
      department: 'Security',
      designation: 'Security Officer',
      phone: '+880 1912-678901',
      status: 'Inactive',
      joinedDate: '28 Nov 2021',
      assignedComplaints: 4,
    ),
    _StaffData(
      name: 'Mst. Jannatul Ferdous',
      email: 'jannatul@uniserva.edu',
      staffId: 'STF-2023-036',
      department: 'Student Services',
      designation: 'Service Coordinator',
      phone: '+880 1612-789012',
      status: 'Active',
      joinedDate: '19 Aug 2023',
      assignedComplaints: 14,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_StaffData> get _filteredStaff {
    final query = _searchController.text.trim().toLowerCase();

    return _staffMembers.where((staff) {
      final matchesSearch = query.isEmpty ||
          staff.name.toLowerCase().contains(query) ||
          staff.email.toLowerCase().contains(query) ||
          staff.staffId.toLowerCase().contains(query) ||
          staff.department.toLowerCase().contains(query) ||
          staff.designation.toLowerCase().contains(query);

      final matchesDepartment = _selectedDepartment == 'All' ||
          staff.department == _selectedDepartment;

      final matchesStatus =
          _selectedStatus == 'All' || staff.status == _selectedStatus;

      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  int get _totalStaff => _staffMembers.length;

  int get _activeStaff =>
      _staffMembers.where((staff) => staff.status == 'Active').length;

  int get _inactiveStaff =>
      _staffMembers.where((staff) => staff.status == 'Inactive').length;

  int get _totalAssignedComplaints => _staffMembers.fold(
    0,
        (total, staff) => total + staff.assignedComplaints,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Staff Management'),
        actions: [
          IconButton(
            onPressed: _showAddStaffDialog,
            tooltip: 'Add Staff',
            icon: const Icon(Icons.person_add_alt_1_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 1024;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 32 : 16,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1440,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildStatistics(isWide),
                      const SizedBox(height: 20),
                      _buildFilters(),
                      const SizedBox(height: 20),
                      _buildResultHeader(),
                      const SizedBox(height: 14),
                      _buildStaffList(isWide),
                      const SizedBox(height: 24),
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

  Widget _buildHeader() {
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
            color: AppColors.black.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.badge_outlined,
              color: AppColors.primaryDark,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Staff Management',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Manage university staff members and their service responsibilities.',
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

  Widget _buildStatistics(bool isWide) {
    final cards = [
      _buildStatCard(
        'Total Staff',
        _totalStaff.toString(),
        Icons.people_alt_outlined,
        AppColors.secondaryLight,
      ),
      _buildStatCard(
        'Active',
        _activeStaff.toString(),
        Icons.check_circle_outline_rounded,
        AppColors.success,
      ),
      _buildStatCard(
        'Inactive',
        _inactiveStaff.toString(),
        Icons.pause_circle_outline_rounded,
        AppColors.error,
      ),
      _buildStatCard(
        'Assigned Complaints',
        _totalAssignedComplaints.toString(),
        Icons.assignment_outlined,
        AppColors.info,
      ),
    ];

    if (isWide) {
      return Row(
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i != cards.length - 1) const SizedBox(width: 14),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 600;

        if (!twoColumns) {
          return Column(
            children: [
              cards[0],
              const SizedBox(height: 12),
              cards[1],
              const SizedBox(height: 12),
              cards[2],
              const SizedBox(height: 12),
              cards[3],
            ],
          );
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 12),
                Expanded(child: cards[1]),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: cards[2]),
                const SizedBox(width: 12),
                Expanded(child: cards[3]),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 23,
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
                    color: AppColors.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wideFilters = constraints.maxWidth >= 850;

          if (wideFilters) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSearchField(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDepartmentDropdown(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatusDropdown(),
                ),
                const SizedBox(width: 12),
                _buildResetButton(),
              ],
            );
          }

          return Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDepartmentDropdown(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatusDropdown(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: _buildResetButton(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) {
        setState(() {});
      },
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      decoration: _inputDecoration(
        hintText: 'Search staff...',
        prefixIcon: Icons.search_rounded,
      ),
    );
  }

  Widget _buildDepartmentDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedDepartment,
      dropdownColor: AppColors.surfaceVariant,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textOnPrimary,
      ),
      decoration: _inputDecoration(
        hintText: 'Department',
        prefixIcon: Icons.business_outlined,
      ),
      items: const [
        DropdownMenuItem(
          value: 'All',
          child: Text('All Departments'),
        ),
        DropdownMenuItem(
          value: 'Information Technology',
          child: Text('Information Technology'),
        ),
        DropdownMenuItem(
          value: 'Library',
          child: Text('Library'),
        ),
        DropdownMenuItem(
          value: 'Student Services',
          child: Text('Student Services'),
        ),
        DropdownMenuItem(
          value: 'Facilities',
          child: Text('Facilities'),
        ),
        DropdownMenuItem(
          value: 'Academic Affairs',
          child: Text('Academic Affairs'),
        ),
        DropdownMenuItem(
          value: 'Security',
          child: Text('Security'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _selectedDepartment = value;
        });
      },
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedStatus,
      dropdownColor: AppColors.surfaceVariant,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textOnPrimary,
      ),
      decoration: _inputDecoration(
        hintText: 'Status',
        prefixIcon: Icons.toggle_on_outlined,
      ),
      items: const [
        DropdownMenuItem(
          value: 'All',
          child: Text('All Statuses'),
        ),
        DropdownMenuItem(
          value: 'Active',
          child: Text('Active'),
        ),
        DropdownMenuItem(
          value: 'Inactive',
          child: Text('Inactive'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _selectedStatus = value;
        });
      },
    );
  }

  Widget _buildResetButton() {
    return OutlinedButton.icon(
      onPressed: _resetFilters,
      icon: const Icon(Icons.refresh_rounded),
      label: const Text('Reset'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondaryLight,
        side: const BorderSide(
          color: AppColors.darkBorder,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildResultHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${_filteredStaff.length} staff members found',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (_selectedDepartment != 'All' || _selectedStatus != 'All')
          Text(
            'Filtered',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.secondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildStaffList(bool isWide) {
    final staff = _filteredStaff;

    if (staff.isEmpty) {
      return _buildEmptyState();
    }

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: staff.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 520,
          mainAxisExtent: 286,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return _buildStaffCard(staff[index]);
        },
      );
    }

    return Column(
      children: [
        for (int i = 0; i < staff.length; i++) ...[
          _buildStaffCard(staff[i]),
          if (i != staff.length - 1) const SizedBox(height: 14),
        ],
      ],
    );
  }

  Widget _buildStaffCard(_StaffData staff) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
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
              CircleAvatar(
                radius: 26,
                backgroundColor:
                AppColors.assigned.withValues(alpha: 0.20),
                child: Text(
                  _initials(staff.name),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      staff.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      staff.designation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.darkTextSecondary,
                ),
                color: AppColors.surfaceVariant,
                onSelected: (value) {
                  if (value == 'view') {
                    _showStaffDetails(staff);
                  } else if (value == 'edit') {
                    _showEditStaffDialog(staff);
                  } else if (value == 'toggle') {
                    _toggleStaffStatus(staff);
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'view',
                      child: Row(
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            size: 19,
                          ),
                          SizedBox(width: 10),
                          Text('View Details'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 19,
                          ),
                          SizedBox(width: 10),
                          Text('Edit Staff'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Row(
                        children: [
                          Icon(
                            staff.status == 'Active'
                                ? Icons.block_outlined
                                : Icons.check_circle_outline_rounded,
                            size: 19,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            staff.status == 'Active'
                                ? 'Deactivate'
                                : 'Activate',
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildBadge(
                staff.department,
                AppColors.assigned,
              ),
              _buildBadge(
                staff.status,
                staff.status == 'Active'
                    ? AppColors.success
                    : AppColors.error,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _staffInfoRow(
            Icons.badge_outlined,
            staff.staffId,
          ),
          const SizedBox(height: 7),
          _staffInfoRow(
            Icons.email_outlined,
            staff.email,
          ),
          const SizedBox(height: 7),
          _staffInfoRow(
            Icons.assignment_outlined,
            '${staff.assignedComplaints} assigned complaints',
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showStaffDetails(staff),
              icon: const Icon(
                Icons.visibility_outlined,
                size: 18,
              ),
              label: const Text('View Staff'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.secondaryLight,
                side: const BorderSide(
                  color: AppColors.darkBorder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _staffInfoRow(
      IconData icon,
      String text,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.secondaryLight,
          size: 17,
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

  Widget _buildBadge(
      String text,
      Color color,
      ) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 210,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: 0.40),
        ),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.labelLarge.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.badge_outlined,
            size: 54,
            color: AppColors.darkTextTertiary,
          ),
          const SizedBox(height: 14),
          Text(
            'No staff members found',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _resetFilters,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reset Filters'),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkTextTertiary,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.secondaryLight,
      ),
      filled: true,
      fillColor: AppColors.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.darkBorder,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.darkBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.secondary,
          width: 1.5,
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts.first.substring(
        0,
        parts.first.length >= 2 ? 2 : 1,
      ).toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  void _resetFilters() {
    _searchController.clear();

    setState(() {
      _selectedDepartment = 'All';
      _selectedStatus = 'All';
    });
  }

  void _toggleStaffStatus(_StaffData staff) {
    setState(() {
      staff.status =
      staff.status == 'Active' ? 'Inactive' : 'Active';
    });

    _showMessage(
      '${staff.name} is now ${staff.status.toLowerCase()}.',
    );
  }

  void _showStaffDetails(_StaffData staff) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Staff Details',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor:
                  AppColors.assigned.withValues(alpha: 0.20),
                  child: Text(
                    _initials(staff.name),
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.secondaryLight,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  staff.name,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  staff.designation,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                _detailRow('Staff ID', staff.staffId),
                _detailRow('Email', staff.email),
                _detailRow('Department', staff.department),
                _detailRow('Phone', staff.phone),
                _detailRow('Joined', staff.joinedDate),
                _detailRow(
                  'Complaints',
                  staff.assignedComplaints.toString(),
                ),
                _detailRow('Status', staff.status),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showEditStaffDialog(staff);
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 18,
              ),
              label: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextTertiary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddStaffDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final idController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Add Staff Member',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogTextField(
                  controller: nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 12),
                _dialogTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 12),
                _dialogTextField(
                  controller: idController,
                  label: 'Staff ID',
                  icon: Icons.badge_outlined,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showMessage(
                  'Staff creation is a mock action for now.',
                );
              },
              icon: const Icon(
                Icons.person_add_alt_1_rounded,
                size: 18,
              ),
              label: const Text('Add Staff'),
            ),
          ],
        );
      },
    );
  }

  void _showEditStaffDialog(_StaffData staff) {
    final nameController = TextEditingController(text: staff.name);
    final designationController =
    TextEditingController(text: staff.designation);
    final phoneController = TextEditingController(text: staff.phone);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Edit Staff',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogTextField(
                  controller: nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 12),
                _dialogTextField(
                  controller: designationController,
                  label: 'Designation',
                  icon: Icons.work_outline_rounded,
                ),
                const SizedBox(height: 12),
                _dialogTextField(
                  controller: phoneController,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  staff.designation = designationController.text.trim().isEmpty
                      ? staff.designation
                      : designationController.text.trim();
                  staff.phone = phoneController.text.trim().isEmpty
                      ? staff.phone
                      : phoneController.text.trim();
                });

                Navigator.pop(dialogContext);

                _showMessage(
                  'Staff information updated.',
                );
              },
              icon: const Icon(
                Icons.save_outlined,
                size: 18,
              ),
              label: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      decoration: _inputDecoration(
        hintText: label,
        prefixIcon: icon,
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class _StaffData {
  _StaffData({
    required this.name,
    required this.email,
    required this.staffId,
    required this.department,
    required this.designation,
    required this.phone,
    required this.status,
    required this.joinedDate,
    required this.assignedComplaints,
  });

  final String name;
  final String email;
  final String staffId;
  final String department;
  String designation;
  String phone;
  String status;
  final String joinedDate;
  final int assignedComplaints;
}