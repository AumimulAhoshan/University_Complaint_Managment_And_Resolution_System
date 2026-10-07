import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/responsive/responsive.dart';

class MyComplaintsScreen extends StatefulWidget {
  const MyComplaintsScreen({super.key});

  @override
  State<MyComplaintsScreen> createState() => _MyComplaintsScreenState();
}

class _MyComplaintsScreenState extends State<MyComplaintsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'All';

  final List<_ComplaintData> _complaints = [
    _ComplaintData(
      number: '#US-1003',
      title: 'Classroom Projector Not Working',
      category: 'IT & Equipment',
      priority: 'High',
      status: 'In Progress',
      date: 'Oct 02, 2026',
      statusColor: AppColors.info,
    ),
    _ComplaintData(
      number: '#US-1002',
      title: 'Washroom Maintenance Required',
      category: 'Maintenance',
      priority: 'Medium',
      status: 'Pending',
      date: 'Oct 01, 2026',
      statusColor: AppColors.warning,
    ),
    _ComplaintData(
      number: '#US-1001',
      title: 'Library AC Problem',
      category: 'Facilities',
      priority: 'Low',
      status: 'Resolved',
      date: 'Sep 29, 2026',
      statusColor: AppColors.success,
    ),
    _ComplaintData(
      number: '#US-1000',
      title: 'Wi-Fi Connection Problem',
      category: 'IT & Equipment',
      priority: 'High',
      status: 'Under Review',
      date: 'Sep 27, 2026',
      statusColor: AppColors.underReview,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_ComplaintData> get _filteredComplaints {
    final query = _searchController.text.trim().toLowerCase();

    return _complaints.where((complaint) {
      final matchesSearch =
          query.isEmpty ||
              complaint.title.toLowerCase().contains(query) ||
              complaint.number.toLowerCase().contains(query) ||
              complaint.category.toLowerCase().contains(query);

      final matchesFilter =
          _selectedFilter == 'All' ||
              complaint.status == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: const Text('My Complaints'),
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
                  _buildHeader(),
                  const SizedBox(height: 18),
                  _buildSearchField(),
                  const SizedBox(height: 16),
                  _buildFilterSection(),
                  const SizedBox(height: 18),
                  _buildComplaintList(
                    isDesktop: isDesktop,
                  ),
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Complaints',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track and manage all your submitted complaints.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.assignment_outlined,
              color: AppColors.primarySurface,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) {
        setState(() {});
      },
      style: const TextStyle(
        color: AppColors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Search complaints...',
        prefixIcon: const Icon(
          Icons.search_rounded,
        ),
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
          onPressed: () {
            _searchController.clear();
            setState(() {});
          },
          icon: const Icon(
            Icons.close_rounded,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    final filters = [
      'All',
      'Pending',
      'In Progress',
      'Resolved',
      'Under Review',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = _selectedFilter == filter;

          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
            backgroundColor: AppColors.surfaceVariant,
            selectedColor: AppColors.primarySurface,
            side: BorderSide(
              color: selected
                  ? AppColors.primarySurface
                  : AppColors.darkBorder,
            ),
            labelStyle: TextStyle(
              color: selected
                  ? AppColors.textPrimary
                  : AppColors.darkTextSecondary,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }

  Widget _buildComplaintList({
    required bool isDesktop,
  }) {
    final complaints = _filteredComplaints;

    if (complaints.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: complaints.map((complaint) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 14,
          ),
          child: _buildComplaintCard(
            complaint,
            isDesktop: isDesktop,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildComplaintCard(
      _ComplaintData complaint, {
        required bool isDesktop,
      }) {
    return Material(
      // Changed to match the dark My Complaints header card.
      color: AppColors.darkSurface,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          context.push(
            '/student/complaint-details?number=${Uri.encodeComponent(complaint.number)}',
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: isDesktop
              ? _buildDesktopComplaintContent(complaint)
              : _buildMobileComplaintContent(complaint),
        ),
      ),
    );
  }

  Widget _buildDesktopComplaintContent(
      _ComplaintData complaint,
      ) {
    return Row(
      children: [
        _buildComplaintIcon(),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: _buildComplaintMainInfo(complaint),
        ),
        const SizedBox(width: 20),
        _buildPriorityBadge(
          complaint.priority,
        ),
        const SizedBox(width: 16),
        _buildStatusBadge(
          complaint.status,
          complaint.statusColor,
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.darkTextTertiary,
        ),
      ],
    );
  }

  Widget _buildMobileComplaintContent(
      _ComplaintData complaint,
      ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComplaintIcon(),
            const SizedBox(width: 14),
            Expanded(
              child: _buildComplaintMainInfo(complaint),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.darkTextTertiary,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _buildPriorityBadge(
              complaint.priority,
            ),
            const SizedBox(width: 8),
            _buildStatusBadge(
              complaint.status,
              complaint.statusColor,
            ),
            const Spacer(),
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
    );
  }

  Widget _buildComplaintIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Icon(
        Icons.description_outlined,
        color: AppColors.primarySurface,
        size: 25,
      ),
    );
  }

  Widget _buildComplaintMainInfo(
      _ComplaintData complaint,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          complaint.number,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          complaint.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Flexible(
              child: Text(
                complaint.category,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '•',
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              complaint.date,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityBadge(String priority) {
    final Color color;

    switch (priority) {
      case 'Low':
        color = AppColors.lowPriority;
        break;
      case 'Medium':
        color = AppColors.mediumPriority;
        break;
      case 'High':
        color = AppColors.highPriority;
        break;
      default:
        color = AppColors.urgentPriority;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.14,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
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
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.14,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
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
        vertical: 48,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: AppColors.primarySurface,
              size: 34,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No complaints found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try changing your search or filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplaintData {
  final String number;
  final String title;
  final String category;
  final String priority;
  final String status;
  final String date;
  final Color statusColor;

  const _ComplaintData({
    required this.number,
    required this.title,
    required this.category,
    required this.priority,
    required this.status,
    required this.date,
    required this.statusColor,
  });
}