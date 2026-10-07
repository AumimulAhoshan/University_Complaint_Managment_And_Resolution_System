import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState
    extends State<CategoryManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedStatus = 'All';
  String _selectedDepartment = 'All';

  final List<_Category> _categories = [
    _Category(
      name: 'Internet & Network',
      description: 'Wi-Fi, internet connectivity and network related issues.',
      department: 'CSE',
      complaintCount: 86,
      isActive: true,
    ),
    _Category(
      name: 'Classroom',
      description: 'Classroom equipment, projector and related issues.',
      department: 'EEE',
      complaintCount: 54,
      isActive: true,
    ),
    _Category(
      name: 'Facilities',
      description: 'Building, electricity, air conditioning and maintenance.',
      department: 'Administration',
      complaintCount: 72,
      isActive: true,
    ),
    _Category(
      name: 'Student Services',
      description: 'Student ID, certificates and student service requests.',
      department: 'Administration',
      complaintCount: 61,
      isActive: true,
    ),
    _Category(
      name: 'Library',
      description: 'Library facilities, books, seats and related services.',
      department: 'BBA',
      complaintCount: 43,
      isActive: true,
    ),
    _Category(
      name: 'Laboratory',
      description: 'Lab equipment, computers and laboratory facilities.',
      department: 'CSE',
      complaintCount: 48,
      isActive: true,
    ),
    _Category(
      name: 'Academic',
      description: 'Academic schedules, courses, exams and related queries.',
      department: 'Academic',
      complaintCount: 39,
      isActive: true,
    ),
    _Category(
      name: 'Transportation',
      description: 'University transport and transportation related issues.',
      department: 'Administration',
      complaintCount: 21,
      isActive: false,
    ),
  ];

  final List<String> _departments = [
    'All',
    'CSE',
    'EEE',
    'BBA',
    'Administration',
    'Academic',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Category> get _filteredCategories {
    final query = _searchController.text.trim().toLowerCase();

    return _categories.where((category) {
      final matchesSearch =
          category.name.toLowerCase().contains(query) ||
              category.description.toLowerCase().contains(query) ||
              category.department.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == 'All' ||
          (_selectedStatus == 'Active' && category.isActive) ||
          (_selectedStatus == 'Inactive' && !category.isActive);

      final matchesDepartment = _selectedDepartment == 'All' ||
          category.department == _selectedDepartment;

      return matchesSearch && matchesStatus && matchesDepartment;
    }).toList();
  }

  int get _activeCount =>
      _categories.where((category) => category.isActive).length;

  int get _inactiveCount =>
      _categories.where((category) => !category.isActive).length;

  int get _totalComplaints => _categories.fold(
    0,
        (sum, category) => sum + category.complaintCount,
  );

  int get _averageComplaints {
    if (_categories.isEmpty) return 0;
    return (_totalComplaints / _categories.length).round();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'All';
      _selectedDepartment = 'All';
    });
  }

  void _showCategoryDetails(_Category category) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            category.name,
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
                _dialogInfo(
                  'Description',
                  category.description,
                ),
                _dialogInfo(
                  'Department',
                  category.department,
                ),
                _dialogInfo(
                  'Complaints',
                  category.complaintCount.toString(),
                ),
                _dialogInfo(
                  'Status',
                  category.isActive ? 'Active' : 'Inactive',
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

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    String department = _departments.length > 1 ? _departments[1] : 'CSE';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _CategoryFormDialog(
          title: 'Add Category',
          nameController: nameController,
          descriptionController: descriptionController,
          departments: _departments.where((item) => item != 'All').toList(),
          initialDepartment: department,
          onSave: (selectedDepartment) {
            final name = nameController.text.trim();
            final description = descriptionController.text.trim();

            if (name.isEmpty || description.isEmpty) {
              return;
            }

            setState(() {
              _categories.insert(
                0,
                _Category(
                  name: name,
                  description: description,
                  department: selectedDepartment,
                  complaintCount: 0,
                  isActive: true,
                ),
              );
            });

            Navigator.pop(dialogContext);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Category added successfully.'),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditCategoryDialog(_Category category) {
    final nameController = TextEditingController(text: category.name);
    final descriptionController =
    TextEditingController(text: category.description);

    String department = category.department;

    if (!_departments.contains(department) || department == 'All') {
      department = _departments.length > 1 ? _departments[1] : 'CSE';
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _CategoryFormDialog(
          title: 'Edit Category',
          nameController: nameController,
          descriptionController: descriptionController,
          departments: _departments.where((item) => item != 'All').toList(),
          initialDepartment: department,
          onSave: (selectedDepartment) {
            final name = nameController.text.trim();
            final description = descriptionController.text.trim();

            if (name.isEmpty || description.isEmpty) {
              return;
            }

            setState(() {
              category.name = name;
              category.description = description;
              category.department = selectedDepartment;
            });

            Navigator.pop(dialogContext);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Category updated successfully.'),
              ),
            );
          },
        );
      },
    );
  }

  void _toggleCategoryStatus(_Category category) {
    final newStatus = !category.isActive;

    setState(() {
      category.isActive = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${category.name} is now ${newStatus ? 'active' : 'inactive'}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Category Management'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            tooltip: 'Add Category',
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add_rounded),
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
                      _buildCategoryContent(isDesktop),
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
                  'Category Management',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage complaint categories and organize them by department.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (!isDesktop) const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Category'),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(bool isDesktop) {
    final stats = [
      _StatItem(
        label: 'Total Categories',
        value: _categories.length.toString(),
        icon: Icons.category_outlined,
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
        label: 'Total Complaints',
        value: _totalComplaints.toString(),
        icon: Icons.assignment_outlined,
      ),
      _StatItem(
        label: 'Avg. Complaints',
        value: _averageComplaints.toString(),
        icon: Icons.analytics_outlined,
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
        crossAxisCount:
        MediaQuery.sizeOf(context).width >= 600 ? 3 : 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.65,
      ),
      itemBuilder: (context, index) {
        return _buildStatCard(stats[index]);
      },
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
            width: isDesktop ? 360 : double.infinity,
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search categories...',
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
          SizedBox(
            width: isDesktop ? 200 : double.infinity,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedDepartment,
              decoration: const InputDecoration(
                labelText: 'Department',
              ),
              items: _departments
                  .map(
                    (department) => DropdownMenuItem(
                  value: department,
                  child: Text(
                    department,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _selectedDepartment = value;
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
          '${_filteredCategories.length} Categories',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          _selectedStatus == 'All'
              ? 'All categories'
              : '$_selectedStatus categories',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryContent(bool isDesktop) {
    final categories = _filteredCategories;

    if (categories.isEmpty) {
      return _buildEmptyState();
    }

    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 470,
          mainAxisExtent: 300,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return _buildCategoryCard(categories[index]);
        },
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildCategoryCard(categories[index]);
      },
    );
  }

  Widget _buildCategoryCard(_Category category) {
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
                child: const Icon(
                  Icons.category_outlined,
                  color: AppColors.secondaryLight,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.darkTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildStatusBadge(category.isActive),
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
                    _showCategoryDetails(category);
                  } else if (value == 'edit') {
                    _showEditCategoryDialog(category);
                  } else if (value == 'toggle') {
                    _toggleCategoryStatus(category);
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
                      child: Text('Edit Category'),
                    ),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Text(
                        category.isActive
                            ? 'Deactivate'
                            : 'Activate',
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            category.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.account_balance_outlined,
            'Department',
            category.department,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.assignment_outlined,
            'Complaints',
            category.complaintCount.toString(),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showCategoryDetails(category),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showEditCategoryDialog(category),
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
            Icons.category_outlined,
            size: 58,
            color: AppColors.darkTextTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'No categories found',
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

class _CategoryFormDialog extends StatefulWidget {
  const _CategoryFormDialog({
    required this.title,
    required this.nameController,
    required this.descriptionController,
    required this.departments,
    required this.initialDepartment,
    required this.onSave,
  });

  final String title;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final List<String> departments;
  final String initialDepartment;
  final void Function(String department) onSave;

  @override
  State<_CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<_CategoryFormDialog> {
  late String _selectedDepartment;

  @override
  void initState() {
    super.initState();
    _selectedDepartment = widget.initialDepartment;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Text(
        widget.title,
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
              controller: widget.nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Icons.category_outlined),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: widget.descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _selectedDepartment,
              decoration: const InputDecoration(
                labelText: 'Department',
                prefixIcon: Icon(Icons.account_balance_outlined),
              ),
              items: widget.departments
                  .map(
                    (department) => DropdownMenuItem(
                  value: department,
                  child: Text(department),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _selectedDepartment = value;
                });
              },
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
          onPressed: () => widget.onSave(_selectedDepartment),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _Category {
  _Category({
    required this.name,
    required this.description,
    required this.department,
    required this.complaintCount,
    required this.isActive,
  });

  String name;
  String description;
  String department;
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