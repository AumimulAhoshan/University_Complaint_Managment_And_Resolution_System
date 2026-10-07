import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedRole = 'All';
  String _selectedStatus = 'All';

  final List<_UserData> _users = [
    _UserData(
      name: 'Aumimul Ahosan',
      email: 'aumimul@example.com',
      id: 'CSE-2022-041',
      department: 'Computer Science & Engineering',
      role: 'Student',
      status: 'Active',
      phone: '+880 1712-345678',
    ),
    _UserData(
      name: 'Nusrat Jahan',
      email: 'nusrat@example.com',
      id: 'EEE-2022-018',
      department: 'Electrical & Electronic Engineering',
      role: 'Student',
      status: 'Active',
      phone: '+880 1812-456789',
    ),
    _UserData(
      name: 'Rakib Hasan',
      email: 'rakib@example.com',
      id: 'BBA-2021-032',
      department: 'Business Administration',
      role: 'Student',
      status: 'Active',
      phone: '+880 1912-567890',
    ),
    _UserData(
      name: 'Sadia Islam',
      email: 'sadia@example.com',
      id: 'CSE-2023-067',
      department: 'Computer Science & Engineering',
      role: 'Student',
      status: 'Inactive',
      phone: '+880 1612-678901',
    ),
    _UserData(
      name: 'Mahmud Ahmed',
      email: 'mahmud@uniserva.edu',
      id: 'STF-2021-017',
      department: 'Information Technology',
      role: 'Staff',
      status: 'Active',
      phone: '+880 1712-789012',
    ),
    _UserData(
      name: 'Sabbir Hossain',
      email: 'sabbir@uniserva.edu',
      id: 'STF-2022-024',
      department: 'Library',
      role: 'Staff',
      status: 'Active',
      phone: '+880 1812-890123',
    ),
    _UserData(
      name: 'Naim Rahman',
      email: 'naim@uniserva.edu',
      id: 'STF-2020-011',
      department: 'Student Services',
      role: 'Staff',
      status: 'Inactive',
      phone: '+880 1912-901234',
    ),
    _UserData(
      name: 'Admin User',
      email: 'admin@uniserva.edu',
      id: 'ADM-2020-001',
      department: 'Administration',
      role: 'Admin',
      status: 'Active',
      phone: '+880 1612-012345',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_UserData> get _filteredUsers {
    final query = _searchController.text.trim().toLowerCase();

    return _users.where((user) {
      final matchesSearch = query.isEmpty ||
          user.name.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query) ||
          user.id.toLowerCase().contains(query) ||
          user.department.toLowerCase().contains(query);

      final matchesRole =
          _selectedRole == 'All' || user.role == _selectedRole;

      final matchesStatus =
          _selectedStatus == 'All' || user.status == _selectedStatus;

      return matchesSearch && matchesRole && matchesStatus;
    }).toList();
  }

  int get _totalUsers => _users.length;

  int get _studentCount =>
      _users.where((user) => user.role == 'Student').length;

  int get _staffCount =>
      _users.where((user) => user.role == 'Staff').length;

  int get _activeCount =>
      _users.where((user) => user.status == 'Active').length;

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
        title: const Text('User Management'),
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
                      _buildFilters(isWide),
                      const SizedBox(height: 20),
                      _buildResultHeader(),
                      const SizedBox(height: 14),
                      _buildUserList(isWide),
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
              Icons.people_alt_outlined,
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
                  'User Management',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Manage students, staff, and administrator accounts.',
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
      _statCard(
        'Total Users',
        _totalUsers.toString(),
        Icons.people_outline_rounded,
        AppColors.secondaryLight,
      ),
      _statCard(
        'Students',
        _studentCount.toString(),
        Icons.school_outlined,
        AppColors.info,
      ),
      _statCard(
        'Staff',
        _staffCount.toString(),
        Icons.badge_outlined,
        AppColors.assigned,
      ),
      _statCard(
        'Active',
        _activeCount.toString(),
        Icons.check_circle_outline_rounded,
        AppColors.success,
      ),
    ];

    if (isWide) {
      return Row(
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i != cards.length - 1)
              const SizedBox(width: 14),
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

  Widget _statCard(
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

  Widget _buildFilters(bool isWide) {
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
          final wideFilters = constraints.maxWidth >= 800;

          if (wideFilters) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSearchField(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRoleDropdown(),
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
                  Expanded(child: _buildRoleDropdown()),
                  const SizedBox(width: 10),
                  Expanded(child: _buildStatusDropdown()),
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
        hintText: 'Search users...',
        prefixIcon: Icons.search_rounded,
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedRole,
      dropdownColor: AppColors.surfaceVariant,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textOnPrimary,
      ),
      decoration: _inputDecoration(
        hintText: 'Role',
        prefixIcon: Icons.manage_accounts_outlined,
      ),
      items: const [
        DropdownMenuItem(
          value: 'All',
          child: Text('All Roles'),
        ),
        DropdownMenuItem(
          value: 'Student',
          child: Text('Student'),
        ),
        DropdownMenuItem(
          value: 'Staff',
          child: Text('Staff'),
        ),
        DropdownMenuItem(
          value: 'Admin',
          child: Text('Admin'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _selectedRole = value;
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
            '${_filteredUsers.length} users found',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (_selectedRole != 'All' || _selectedStatus != 'All')
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

  Widget _buildUserList(bool isWide) {
    final users = _filteredUsers;

    if (users.isEmpty) {
      return _buildEmptyState();
    }

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 520,
          mainAxisExtent: 250,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return _buildUserCard(users[index]);
        },
      );
    }

    return Column(
      children: [
        for (int i = 0; i < users.length; i++) ...[
          _buildUserCard(users[i]),
          if (i != users.length - 1)
            const SizedBox(height: 14),
        ],
      ],
    );
  }

  Widget _buildUserCard(_UserData user) {
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
                radius: 25,
                backgroundColor: _roleColor(user.role)
                    .withValues(alpha: 0.20),
                child: Text(
                  _initials(user.name),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: _roleColor(user.role),
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
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      user.email,
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
                    _showUserDetails(user);
                  } else if (value == 'toggle') {
                    _toggleUserStatus(user);
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
                    PopupMenuItem(
                      value: 'toggle',
                      child: Row(
                        children: [
                          Icon(
                            user.status == 'Active'
                                ? Icons.block_outlined
                                : Icons.check_circle_outline_rounded,
                            size: 19,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            user.status == 'Active'
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
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildRoleBadge(user.role),
              _buildStatusBadge(user.status),
            ],
          ),
          const SizedBox(height: 14),
          _userInfoRow(
            Icons.badge_outlined,
            user.id,
          ),
          const SizedBox(height: 7),
          _userInfoRow(
            Icons.business_outlined,
            user.department,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showUserDetails(user),
              icon: const Icon(
                Icons.visibility_outlined,
                size: 18,
              ),
              label: const Text('View User'),
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

  Widget _userInfoRow(
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

  Widget _buildRoleBadge(String role) {
    return _badge(
      role,
      _roleColor(role),
    );
  }

  Widget _buildStatusBadge(String status) {
    return _badge(
      status,
      status == 'Active'
          ? AppColors.success
          : AppColors.error,
    );
  }

  Widget _badge(
      String text,
      Color color,
      ) {
    return Container(
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
        style: AppTextStyles.labelLarge.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
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
            Icons.person_search_rounded,
            size: 54,
            color: AppColors.darkTextTertiary,
          ),
          const SizedBox(height: 14),
          Text(
            'No users found',
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

  Color _roleColor(String role) {
    switch (role) {
      case 'Student':
        return AppColors.info;
      case 'Staff':
        return AppColors.assigned;
      case 'Admin':
        return AppColors.secondaryLight;
      default:
        return AppColors.darkTextSecondary;
    }
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
      _selectedRole = 'All';
      _selectedStatus = 'All';
    });
  }

  void _toggleUserStatus(_UserData user) {
    setState(() {
      user.status = user.status == 'Active'
          ? 'Inactive'
          : 'Active';
    });

    _showMessage(
      '${user.name} is now ${user.status.toLowerCase()}.',
    );
  }

  void _showUserDetails(_UserData user) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'User Details',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 34,
                    backgroundColor:
                    _roleColor(user.role).withValues(alpha: 0.20),
                    child: Text(
                      _initials(user.name),
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: _roleColor(user.role),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: Text(
                    user.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                _detailRow('Email', user.email),
                _detailRow('ID', user.id),
                _detailRow('Department', user.department),
                _detailRow('Role', user.role),
                _detailRow('Phone', user.phone),
                _detailRow('Status', user.status),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _toggleUserStatus(user);
              },
              child: Text(
                user.status == 'Active'
                    ? 'Deactivate'
                    : 'Activate',
              ),
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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class _UserData {
  _UserData({
    required this.name,
    required this.email,
    required this.id,
    required this.department,
    required this.role,
    required this.status,
    required this.phone,
  });

  final String name;
  final String email;
  final String id;
  final String department;
  final String role;
  String status;
  final String phone;
}