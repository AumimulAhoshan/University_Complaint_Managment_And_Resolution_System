import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class AdminComplaintDetailsScreen extends StatefulWidget {
  const AdminComplaintDetailsScreen({
    super.key,
    this.complaintNumber,
  });

  final String? complaintNumber;

  @override
  State<AdminComplaintDetailsScreen> createState() =>
      _AdminComplaintDetailsScreenState();
}

class _AdminComplaintDetailsScreenState
    extends State<AdminComplaintDetailsScreen> {
  late String _status;
  late String _assignedStaff;

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _resolutionController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    _status = 'In Progress';
    _assignedStaff = 'Mahmud Ahmed';
  }

  @override
  void dispose() {
    _commentController.dispose();
    _resolutionController.dispose();
    super.dispose();
  }

  String get _complaintNumber =>
      widget.complaintNumber ?? 'CMP-2026-00486';

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
        title: const Text('Complaint Details'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 1024;

            return _buildContent(context, isWide);
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      bool isWide,
      ) {
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
          child: isWide
              ? _buildWideLayout(context)
              : _buildMobileLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComplaintHeader(context),
        const SizedBox(height: 16),
        _buildRequesterCard(),
        const SizedBox(height: 16),
        _buildComplaintInformation(),
        const SizedBox(height: 16),
        _buildDescriptionCard(),
        const SizedBox(height: 16),
        _buildAttachmentsCard(),
        const SizedBox(height: 16),
        _buildTimelineCard(),
        const SizedBox(height: 16),
        _buildAssignmentCard(),
        const SizedBox(height: 16),
        _buildCommentsCard(),
        const SizedBox(height: 16),
        _buildResolutionCard(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComplaintHeader(context),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  _buildRequesterCard(),
                  const SizedBox(height: 16),
                  _buildComplaintInformation(),
                  const SizedBox(height: 16),
                  _buildDescriptionCard(),
                  const SizedBox(height: 16),
                  _buildAttachmentsCard(),
                  const SizedBox(height: 16),
                  _buildCommentsCard(),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildTimelineCard(),
                  const SizedBox(height: 16),
                  _buildAssignmentCard(),
                  const SizedBox(height: 16),
                  _buildResolutionCard(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildComplaintHeader(BuildContext context) {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatusBadge(_status),
              _buildPriorityBadge('High'),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Wi-Fi connection issue',
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.textOnPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _complaintNumber,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.secondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _actionButton(
                label: 'Update Status',
                icon: Icons.sync_rounded,
                onPressed: _showStatusDialog,
              ),
              _actionButton(
                label: 'Assign Staff',
                icon: Icons.person_add_alt_1_rounded,
                onPressed: _showAssignmentDialog,
              ),
              _actionButton(
                label: 'Mark Resolved',
                icon: Icons.check_circle_outline_rounded,
                onPressed: _showResolveDialog,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequesterCard() {
    return _sectionCard(
      title: 'Requester Information',
      icon: Icons.person_outline_rounded,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primarySurface,
            child: Text(
              'AA',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aumimul Ahosan',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Student ID: CSE-2022-041',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'aumimul@example.com',
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

  Widget _buildComplaintInformation() {
    return _sectionCard(
      title: 'Complaint Information',
      icon: Icons.info_outline_rounded,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final twoColumns = constraints.maxWidth > 500;

          final items = [
            _infoItem(
              'Department',
              'Computer Science & Engineering',
              Icons.business_rounded,
            ),
            _infoItem(
              'Category',
              'Internet & Network',
              Icons.category_outlined,
            ),
            _infoItem(
              'Location',
              'Academic Building - 3rd Floor',
              Icons.location_on_outlined,
            ),
            _infoItem(
              'Submitted',
              '03 Oct 2026, 10:30 AM',
              Icons.calendar_today_outlined,
            ),
          ];

          if (!twoColumns) {
            return Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  items[i],
                  if (i != items.length - 1)
                    const SizedBox(height: 14),
                ],
              ],
            );
          }

          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: items[0]),
                  const SizedBox(width: 16),
                  Expanded(child: items[1]),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: items[2]),
                  const SizedBox(width: 16),
                  Expanded(child: items[3]),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return _sectionCard(
      title: 'Description',
      icon: Icons.description_outlined,
      child: Text(
        'The Wi-Fi connection on the third floor of the academic '
            'building has been unstable since this morning. Students are '
            'experiencing frequent disconnections and very slow internet '
            'speeds. The issue is affecting online classes and access to '
            'university resources.',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextSecondary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildAttachmentsCard() {
    return _sectionCard(
      title: 'Attachments',
      icon: Icons.attach_file_rounded,
      child: Column(
        children: [
          _attachmentItem(
            'wifi_problem.jpg',
            'Image • 1.2 MB',
            Icons.image_outlined,
          ),
          const SizedBox(height: 10),
          _attachmentItem(
            'speed_test.png',
            'Image • 850 KB',
            Icons.image_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard() {
    final timeline = [
      _TimelineItem(
        title: 'Submitted',
        subtitle: '03 Oct 2026, 10:30 AM',
        description: 'Complaint submitted by Aumimul Ahosan.',
        color: AppColors.submitted,
        icon: Icons.send_rounded,
      ),
      _TimelineItem(
        title: 'Under Review',
        subtitle: '03 Oct 2026, 11:05 AM',
        description: 'Complaint reviewed by administration.',
        color: AppColors.underReview,
        icon: Icons.visibility_outlined,
      ),
      _TimelineItem(
        title: 'Assigned',
        subtitle: '03 Oct 2026, 11:20 AM',
        description: 'Assigned to Mahmud Ahmed.',
        color: AppColors.assigned,
        icon: Icons.person_outline_rounded,
      ),
      _TimelineItem(
        title: 'In Progress',
        subtitle: '03 Oct 2026, 11:40 AM',
        description:
        'Technical team started investigating the issue.',
        color: AppColors.inProgress,
        icon: Icons.build_outlined,
      ),
    ];

    return _sectionCard(
      title: 'Status Timeline',
      icon: Icons.timeline_rounded,
      child: Column(
        children: [
          for (int i = 0; i < timeline.length; i++)
            _buildTimelineItem(
              item: timeline[i],
              isLast: i == timeline.length - 1,
            ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard() {
    return _sectionCard(
      title: 'Assignment',
      icon: Icons.assignment_ind_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primarySurface,
                child: Text(
                  _assignedStaff == 'Unassigned' ? '?' : 'MA',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryDark,
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
                      _assignedStaff,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _assignedStaff == 'Unassigned'
                          ? 'No staff assigned'
                          : 'IT Support Officer',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showAssignmentDialog,
              icon: const Icon(Icons.swap_horiz_rounded),
              label: const Text('Change Assignment'),
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

  Widget _buildCommentsCard() {
    return _sectionCard(
      title: 'Comments',
      icon: Icons.chat_bubble_outline_rounded,
      child: Column(
        children: [
          _commentItem(
            initials: 'MA',
            name: 'Mahmud Ahmed',
            role: 'Staff',
            comment:
            'I have checked the access point on the third floor. '
                'I am investigating the connectivity issue.',
            time: '03 Oct 2026, 12:10 PM',
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _commentController,
            minLines: 2,
            maxLines: 4,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextPrimary,
            ),
            decoration: _inputDecoration(
              hintText: 'Write a comment...',
              prefixIcon: Icons.edit_outlined,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _addComment,
              icon: const Icon(
                Icons.send_rounded,
                size: 18,
              ),
              label: const Text('Add Comment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResolutionCard() {
    return _sectionCard(
      title: 'Resolution Notes',
      icon: Icons.task_alt_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add resolution information when the complaint is resolved.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _resolutionController,
            minLines: 4,
            maxLines: 6,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextPrimary,
            ),
            decoration: _inputDecoration(
              hintText: 'Enter resolution notes...',
              prefixIcon: Icons.notes_rounded,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _saveResolution,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Resolution Notes'),
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

  Widget _sectionCard({
    String? title,
    IconData? icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: AppColors.secondaryLight,
                    size: 21,
                  ),
                  const SizedBox(width: 9),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
          ],
          child,
        ],
      ),
    );
  }

  Widget _infoItem(
      String label,
      String value,
      IconData icon,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.secondaryLight,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
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
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _attachmentItem(
      String fileName,
      String details,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  details,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showMessage(
                'Attachment preview is not connected yet.',
              );
            },
            icon: const Icon(Icons.visibility_outlined),
            color: AppColors.secondaryLight,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required _TimelineItem item,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 16,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 52,
                  color: AppColors.darkBorder,
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _commentItem({
    required String initials,
    required String name,
    required String role,
    required String comment,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primarySurface,
          child: Text(
            initials,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      role,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  comment,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primaryDark,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return _badge(
      status,
      _statusColor(status),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    return _badge(
      priority,
      AppColors.highPriority,
    );
  }

  Widget _badge(
      String text,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelLarge.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
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
      case 'Reopened':
        return AppColors.reopened;
      default:
        return AppColors.secondaryLight;
    }
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

  void _showStatusDialog() {
    String selectedStatus = _status;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              title: Text(
                'Update Status',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                dropdownColor: AppColors.surfaceVariant,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                decoration: _inputDecoration(
                  hintText: 'Select status',
                  prefixIcon: Icons.sync_rounded,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Submitted',
                    child: Text('Submitted'),
                  ),
                  DropdownMenuItem(
                    value: 'Under Review',
                    child: Text('Under Review'),
                  ),
                  DropdownMenuItem(
                    value: 'Assigned',
                    child: Text('Assigned'),
                  ),
                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('In Progress'),
                  ),
                  DropdownMenuItem(
                    value: 'Resolved',
                    child: Text('Resolved'),
                  ),
                  DropdownMenuItem(
                    value: 'Closed',
                    child: Text('Closed'),
                  ),
                  DropdownMenuItem(
                    value: 'Reopened',
                    child: Text('Reopened'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() {
                      selectedStatus = value;
                    });
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _status = selectedStatus;
                    });

                    Navigator.pop(dialogContext);

                    _showMessage(
                      'Complaint status updated.',
                    );
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAssignmentDialog() {
    String selectedStaff = _assignedStaff;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              title: Text(
                'Assign Staff',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: DropdownButtonFormField<String>(
                initialValue: selectedStaff,
                dropdownColor: AppColors.surfaceVariant,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                decoration: _inputDecoration(
                  hintText: 'Select staff',
                  prefixIcon: Icons.person_outline_rounded,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Unassigned',
                    child: Text('Unassigned'),
                  ),
                  DropdownMenuItem(
                    value: 'Mahmud Ahmed',
                    child: Text('Mahmud Ahmed'),
                  ),
                  DropdownMenuItem(
                    value: 'Sabbir Hossain',
                    child: Text('Sabbir Hossain'),
                  ),
                  DropdownMenuItem(
                    value: 'Naim Rahman',
                    child: Text('Naim Rahman'),
                  ),
                  DropdownMenuItem(
                    value: 'Rashed Karim',
                    child: Text('Rashed Karim'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() {
                      selectedStaff = value;
                    });
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _assignedStaff = selectedStaff;
                    });

                    Navigator.pop(dialogContext);

                    _showMessage(
                      'Staff assignment updated.',
                    );
                  },
                  child: const Text('Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showResolveDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Mark as Resolved?',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'This will change the complaint status to Resolved.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
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
                  _status = 'Resolved';
                });

                Navigator.pop(dialogContext);

                _showMessage(
                  'Complaint marked as resolved.',
                );
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
              ),
              label: const Text('Resolve'),
            ),
          ],
        );
      },
    );
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) {
      _showMessage(
        'Please write a comment first.',
      );
      return;
    }

    _commentController.clear();

    _showMessage(
      'Comment added successfully.',
    );
  }

  void _saveResolution() {
    if (_resolutionController.text.trim().isEmpty) {
      _showMessage(
        'Please enter resolution notes.',
      );
      return;
    }

    _showMessage(
      'Resolution notes saved.',
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

class _TimelineItem {
  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String description;
  final Color color;
  final IconData icon;
}