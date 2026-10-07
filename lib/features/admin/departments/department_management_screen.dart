import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class DepartmentManagementScreen extends StatefulWidget {
  const DepartmentManagementScreen({super.key});

  @override
  State<DepartmentManagementScreen> createState() =>
      _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState
    extends State<DepartmentManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedStatus = 'All';

  final List<_Department> _departments = [
    _Department(
      name: 'Computer Science & Engineering',
      code: 'CSE',
      head: 'Dr. Rahman Ahmed',
      staffCount: 28,
      studentCount: 420,
      complaintCount: 86,
      isActive: true,
    ),
    _Department(
      name: 'Electrical & Electronic Engineering',
      code: 'EEE',
      head: 'Dr. Kamal Hossain',
      staffCount: 24,
      studentCount: 360,
      complaintCount: 72,
      isActive: true,
    ),
    _Department(
      name: 'Business Administration',
      code: 'BBA',
      head: 'Dr. Farzana Akter',
      staffCount: 18,
      studentCount: 285,
      complaintCount: 58,
      isActive: true,
    ),
    _Department(
      name: 'English',
      code: 'ENG',
      head: 'Dr. Nusrat Jahan',
      staffCount: 14,
      studentCount: 210,
      complaintCount: 41,
      isActive: true,
    ),
    _Department(
      name: 'Civil Engineering',
      code: 'CE',
      head: 'Dr. Mahmud Hasan',
      staffCount: 20,
      studentCount: 290,
      complaintCount: 47,
      isActive: true,
    ),
    _Department(
      name: 'Electrical Engineering',
      code: 'ETE',
      head: 'Dr. Saiful Islam',
      staffCount: 12,
      studentCount: 175,
      complaintCount: 29,
      isActive: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Department> get _filteredDepartments {
    final query = _searchController.text.trim().toLowerCase();

    return _departments.where((department) {
      final matchesSearch =
          department.name.toLowerCase().contains(query) ||
              department.code.toLowerCase().contains(query) ||
              department.head.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == 'All' ||
          (_selectedStatus == 'Active' && department.isActive) ||
          (_selectedStatus == 'Inactive' && !department.isActive);

      return matchesSearch && matchesStatus;
    }).toList();
  }

  int get _activeCount =>
      _departments.where((department) => department.isActive).length;

  int get _inactiveCount =>
      _departments.where((department) => !department.isActive).length;

  int get _totalStudents => _departments.fold(
    0,
        (sum, department) => sum + department.studentCount,
  );

  int get _totalStaff => _departments.fold(
    0,
        (sum, department) => sum + department.staffCount,
  );

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'All';
    });
  }

  void _showDepartmentDetails(_Department department) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            department.name,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogInfo('Department Code', department.code),
                _dialogInfo('Department Head', department.head),
                _dialogInfo(
                  'Status',
                  department.isActive ? 'Active' : 'Inactive',
                ),
                _dialogInfo(
                  'Staff Members',
                  department.staffCount.toString(),
                ),
                _dialogInfo(
                  'Students',
                  department.studentCount.toString(),
                ),
                _dialogInfo(
                  'Complaints',
                  department.complaintCount.toString(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Close',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.secondaryLight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
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
    );
  }

  void _showAddDepartmentDialog() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();
    final headController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _DepartmentFormDialog(
          title: 'Add Department',
          nameController: nameController,
          codeController: codeController,
          headController: headController,
          onSave: () {
            final name = nameController.text.trim();
            final code = codeController.text.trim();
            final head = headController.text.trim();

            if (name.isEmpty || code.isEmpty || head.isEmpty) {
              return;
            }

            setState(() {
              _departments.insert(
                0,
                _Department(
                  name: name,
                  code: code.toUpperCase(),
                  head: head,
                  staffCount: 0,
                  studentCount: 0,
                  complaintCount: 0,
                  isActive: true,
                ),
              );
            });

            Navigator.pop(dialogContext);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Department added successfully.'),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditDepartmentDialog(_Department department) {
    final nameController = TextEditingController(text: department.name);
    final codeController = TextEditingController(text: department.code);
    final headController = TextEditingController(text: department.head);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _DepartmentFormDialog(
          title: 'Edit Department',
          nameController: nameController,
          codeController: codeController,
          headController: headController,
          onSave: () {
            final name = nameController.text.trim();
            final code = codeController.text.trim();
            final head = headController.text.trim();

            if (name.isEmpty || code.isEmpty || head.isEmpty) {
              return;
            }

            setState(() {
              department.name = name;
              department.code = code.toUpperCase();
              department.head = head;
            });

            Navigator.pop(dialogContext);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Department updated successfully.'),
              ),
            );
          },
        );
      },
    );
  }

  void _toggleDepartmentStatus(_Department department) {
    final newStatus = !department.isActive;

    setState(() {
      department.isActive = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${department.name} is now ${newStatus ? 'active' : 'inactive'}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Department Management'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            tooltip: 'Add Department',
            onPressed: _showAddDepartmentDialog,
            icon: const Icon(Icons.add_business_rounded),
          ),
          const SizedBox(width: 8),
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
                  constraints: const BoxConstraints(maxWidth: 1440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(isDesktop),
                      const SizedBox(height: 20),
                      _buildStats(isDesktop),
                      const SizedBox(height: 20),
                      _buildFilters(isDesktop),
                      const SizedBox(height: 16),
                      _buildResultsHeader(),
                      const SizedBox(height: 12),
                      _buildDepartmentContent(isDesktop),
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
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Department Management',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage university departments, department heads, and organizational information.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (!isDesktop) const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _showAddDepartmentDialog,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Department'),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(bool isDesktop) {
    final stats = [
      _StatItem(
        label: 'Total Departments',
        value: _departments.length.toString(),
        icon: Icons.account_balance_rounded,
      ),
      _StatItem(
        label: 'Active',
        value: _activeCount.toString(),
        icon: Icons.check_circle_outline_rounded,
      ),
      _StatItem(
        label: 'Inactive',
        value: _inactiveCount.toString(),
        icon: Icons.pause_circle_outline_rounded,
      ),
      _StatItem(
        label: 'Total Students',
        value: _totalStudents.toString(),
        icon: Icons.school_outlined,
      ),
      _StatItem(
        label: 'Total Staff',
        value: _totalStaff.toString(),
        icon: Icons.groups_outlined,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: stats
            .map(
              (stat) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildStatCard(stat),
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
        crossAxisCount: MediaQuery.sizeOf(context).width >= 600 ? 3 : 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.65,
      ),
      itemBuilder: (context, index) => _buildStatCard(stats[index]),
    );
  }

  Widget _buildStatCard(_StatItem stat) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            stat.icon,
            color: AppColors.secondaryLight,
            size: 25,
          ),
          const Spacer(),
          Text(
            stat.value,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            stat.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: isDesktop ? 380 : double.infinity,
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search departments...',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          SizedBox(
            width: isDesktop ? 180 : double.infinity,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All Status'),
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
            ),
          ),
          OutlinedButton.icon(
            onPressed: _resetFilters,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Row(
      children: [
        Text(
          '${_filteredDepartments.length} Departments',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          _selectedStatus == 'All'
              ? 'All departments'
              : '$_selectedStatus departments',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentContent(bool isDesktop) {
    final departments = _filteredDepartments;

    if (departments.isEmpty) {
      return _buildEmptyState();
    }

    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: departments.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 470,
          mainAxisExtent: 320,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return _buildDepartmentCard(departments[index]);
        },
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: departments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildDepartmentCard(departments[index]);
      },
    );
  }

  Widget _buildDepartmentCard(_Department department) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    department.code,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.secondaryLight,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.darkTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildStatusBadge(department.isActive),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.darkTextSecondary,
                ),
                color: AppColors.surface,
                onSelected: (value) {
                  if (value == 'details') {
                    _showDepartmentDetails(department);
                  } else if (value == 'edit') {
                    _showEditDepartmentDialog(department);
                  } else if (value == 'toggle') {
                    _toggleDepartmentStatus(department);
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'details',
                      child: Text('View Details'),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit Department'),
                    ),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Text(
                        department.isActive ? 'Deactivate' : 'Activate',
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildInfoRow(
            Icons.person_outline_rounded,
            'Department Head',
            department.head,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.groups_outlined,
            'Staff Members',
            department.staffCount.toString(),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.school_outlined,
            'Students',
            department.studentCount.toString(),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.assignment_outlined,
            'Complaints',
            department.complaintCount.toString(),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showDepartmentDetails(department),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showEditDepartmentDialog(department),
                  child: const Text('Edit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    final color = isActive ? AppColors.success : AppColors.textTertiary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: AppTextStyles.bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: AppColors.secondaryLight,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextTertiary,
            ),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_outlined,
            size: 58,
            color: AppColors.darkTextTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'No departments found',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your search or filter.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton(
            onPressed: _resetFilters,
            child: const Text('Reset Filters'),
          ),
        ],
      ),
    );
  }
}

class _DepartmentFormDialog extends StatelessWidget {
  const _DepartmentFormDialog({
    required this.title,
    required this.nameController,
    required this.codeController,
    required this.headController,
    required this.onSave,
  });

  final String title;
  final TextEditingController nameController;
  final TextEditingController codeController;
  final TextEditingController headController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Department Name',
                prefixIcon: Icon(Icons.account_balance_outlined),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: codeController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Department Code',
                prefixIcon: Icon(Icons.tag_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: headController,
              decoration: const InputDecoration(
                labelText: 'Department Head',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _Department {
  _Department({
    required this.name,
    required this.code,
    required this.head,
    required this.staffCount,
    required this.studentCount,
    required this.complaintCount,
    required this.isActive,
  });

  String name;
  String code;
  String head;
  int staffCount;
  int studentCount;
  int complaintCount;
  bool isActive;
}

class _StatItem {
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}