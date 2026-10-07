import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class StaffComplaintDetailsScreen extends StatefulWidget {
  const StaffComplaintDetailsScreen({
    super.key,
    this.complaintNumber,
  });

  final String? complaintNumber;

  @override
  State<StaffComplaintDetailsScreen> createState() =>
      _StaffComplaintDetailsScreenState();
}

class _StaffComplaintDetailsScreenState
    extends State<StaffComplaintDetailsScreen> {
  late String _currentStatus;

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _resolutionController =
  TextEditingController();

  final List<String> _statusOptions = const [
    'Assigned',
    'In Progress',
    'Resolved',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();
    _currentStatus = 'Assigned';
  }

  @override
  void dispose() {
    _commentController.dispose();
    _resolutionController.dispose();
    super.dispose();
  }

  String get _complaintNumber =>
      widget.complaintNumber ?? 'CMP-2026-0018';

  // ------------------------------------------------------------
  // BACK NAVIGATION
  // ------------------------------------------------------------

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.go('/staff/complaints');
    }
  }

  // ------------------------------------------------------------
  // STATUS UPDATE
  // ------------------------------------------------------------

  void _showUpdateStatusDialog() {
    String selectedStatus = _currentStatus;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.darkSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                'Update Complaint Status',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.darkTextPrimary,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select the new status for this complaint.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    initialValue: selectedStatus,
                    dropdownColor: AppColors.darkSurface,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.darkTextPrimary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Status',
                      labelStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.darkSurfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.darkBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColors.secondary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    items: _statusOptions.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setDialogState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStatus = selectedStatus;
                    });

                    Navigator.of(dialogContext).pop();

                    _showSuccessMessage(
                      'Complaint status updated to $selectedStatus.',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.textPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // RESOLVE COMPLAINT
  // ------------------------------------------------------------

  void _showResolveDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Resolve Complaint',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
            ),
          ),
          content: Text(
            'Are you sure you want to mark this complaint as resolved?',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentStatus = 'Resolved';
                });

                Navigator.of(dialogContext).pop();

                _showSuccessMessage(
                  'Complaint marked as resolved.',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Resolve',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // COMMENTS
  // ------------------------------------------------------------

  void _addComment() {
    if (_commentController.text.trim().isEmpty) {
      _showSuccessMessage('Please enter a comment first.');
      return;
    }

    _commentController.clear();

    _showSuccessMessage('Comment added successfully.');
  }

  // ------------------------------------------------------------
  // RESOLUTION NOTES
  // ------------------------------------------------------------

  void _saveResolutionNotes() {
    if (_resolutionController.text.trim().isEmpty) {
      _showSuccessMessage('Please enter resolution notes first.');
      return;
    }

    _showSuccessMessage('Resolution notes saved successfully.');
  }

  // ------------------------------------------------------------
  // SNACKBAR
  // ------------------------------------------------------------

  void _showSuccessMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  // ------------------------------------------------------------
  // STATUS COLOR
  // ------------------------------------------------------------

  Color _statusColor(String status) {
    switch (status) {
      case 'Assigned':
        return AppColors.assigned;
      case 'In Progress':
        return AppColors.inProgress;
      case 'Resolved':
        return AppColors.resolved;
      case 'Closed':
        return AppColors.closed;
      default:
        return AppColors.info;
    }
  }

  // ------------------------------------------------------------
  // STATUS BADGE
  // ------------------------------------------------------------

  Widget _buildStatusBadge() {
    final color = _statusColor(_currentStatus);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
        ),
      ),
      child: Text(
        _currentStatus,
        style: AppTextStyles.labelLarge.copyWith(
          color: color,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // INFO ITEM
  // ------------------------------------------------------------

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.secondary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
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
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // SECTION CARD
  // ------------------------------------------------------------

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.secondary,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
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
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // COMPLAINT HEADER
  // ------------------------------------------------------------

  Widget _buildComplaintHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                _complaintNumber,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _buildStatusBadge(),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Classroom Projector Not Working',
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'The projector in Room 402 is not displaying any image during classes.',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildSmallTag(
                'High Priority',
                AppColors.highPriority,
              ),
              _buildSmallTag(
                'IT & Technical',
                AppColors.info,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // SMALL TAG
  // ------------------------------------------------------------

  Widget _buildSmallTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelLarge.copyWith(
          color: color,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // DESCRIPTION
  // ------------------------------------------------------------

  Widget _buildDescription() {
    return _buildSectionCard(
      title: 'Complaint Description',
      icon: Icons.description_outlined,
      child: Text(
        'The projector installed in Room 402 has stopped displaying '
            'content from the classroom computer. The projector powers on, '
            'but the screen remains blank. The issue started during the '
            'afternoon class yesterday. Several students are unable to '
            'follow the lecture properly because the presentation cannot be '
            'displayed.',
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.darkTextSecondary,
          height: 1.6,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // STUDENT INFORMATION
  // ------------------------------------------------------------

  Widget _buildStudentInformation() {
    return _buildSectionCard(
      title: 'Student Information',
      icon: Icons.person_outline_rounded,
      child: Column(
        children: [
          _buildInfoItem(
            icon: Icons.person_outline_rounded,
            label: 'Student',
            value: 'Aumimul Ahosan',
          ),
          const SizedBox(height: 18),
          _buildInfoItem(
            icon: Icons.badge_outlined,
            label: 'Student ID',
            value: 'CSE-2022-041',
          ),
          const SizedBox(height: 18),
          _buildInfoItem(
            icon: Icons.school_outlined,
            label: 'Department',
            value: 'Computer Science & Engineering',
          ),
          const SizedBox(height: 18),
          _buildInfoItem(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'student@university.edu',
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // COMPLAINT INFORMATION
  // ------------------------------------------------------------

  Widget _buildComplaintInformation() {
    return _buildSectionCard(
      title: 'Complaint Information',
      icon: Icons.info_outline_rounded,
      child: Column(
        children: [
          _buildInfoItem(
            icon: Icons.category_outlined,
            label: 'Category',
            value: 'IT & Technical',
          ),
          const SizedBox(height: 18),
          _buildInfoItem(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Room 402, Academic Building',
          ),
          const SizedBox(height: 18),
          _buildInfoItem(
            icon: Icons.calendar_today_outlined,
            label: 'Submitted',
            value: '02 October 2026, 10:35 AM',
          ),
          const SizedBox(height: 18),
          _buildInfoItem(
            icon: Icons.priority_high_rounded,
            label: 'Priority',
            value: 'High',
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // TIMELINE
  // ------------------------------------------------------------

  Widget _buildTimeline() {
    final events = [
      {
        'title': 'Complaint Submitted',
        'description': 'Complaint was submitted by the student.',
        'date': '02 Oct 2026 • 10:35 AM',
        'color': AppColors.submitted,
        'icon': Icons.send_outlined,
      },
      {
        'title': 'Under Review',
        'description': 'Complaint was reviewed by the service team.',
        'date': '02 Oct 2026 • 11:20 AM',
        'color': AppColors.underReview,
        'icon': Icons.visibility_outlined,
      },
      {
        'title': 'Assigned',
        'description': 'Complaint assigned to the IT support team.',
        'date': '02 Oct 2026 • 12:10 PM',
        'color': AppColors.assigned,
        'icon': Icons.assignment_ind_outlined,
      },
      {
        'title': _currentStatus,
        'description': 'Current complaint status.',
        'date': 'Current status',
        'color': _statusColor(_currentStatus),
        'icon': Icons.sync_alt_rounded,
      },
    ];

    return _buildSectionCard(
      title: 'Status Timeline',
      icon: Icons.timeline_rounded,
      child: Column(
        children: List.generate(
          events.length,
              (index) {
            final event = events[index];
            final isLast = index == events.length - 1;
            final color = event['color']! as Color;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: color.withValues(alpha: 0.45),
                        ),
                      ),
                      child: Icon(
                        event['icon']! as IconData,
                        color: color,
                        size: 19,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 48,
                        color: AppColors.darkBorder,
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title']! as String,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.darkTextPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['description']! as String,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          event['date']! as String,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // ASSIGNMENT
  // ------------------------------------------------------------

  Widget _buildAssignment() {
    return _buildSectionCard(
      title: 'Assignment',
      icon: Icons.assignment_ind_outlined,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'MA',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mahmud Ahmed',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'IT Support Officer',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          _buildSmallTag(
            'Assigned',
            AppColors.assigned,
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ATTACHMENTS
  // ------------------------------------------------------------

  Widget _buildAttachments() {
    return _buildSectionCard(
      title: 'Attachments',
      icon: Icons.attach_file_rounded,
      child: Column(
        children: [
          _buildAttachmentItem(
            icon: Icons.image_outlined,
            name: 'projector_issue.jpg',
            size: '1.8 MB',
          ),
          const SizedBox(height: 10),
          _buildAttachmentItem(
            icon: Icons.picture_as_pdf_outlined,
            name: 'classroom_report.pdf',
            size: '420 KB',
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem({
    required IconData icon,
    required String name,
    required String size,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  size,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showSuccessMessage('Attachment preview opened.');
            },
            icon: const Icon(
              Icons.visibility_outlined,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // COMMENTS
  // ------------------------------------------------------------

  Widget _buildComments() {
    return _buildSectionCard(
      title: 'Staff Comments',
      icon: Icons.comment_outlined,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mahmud Ahmed',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'I have checked the projector connection and will inspect '
                      'the HDMI cable and display settings.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '02 Oct 2026 • 12:30 PM',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _commentController,
            maxLines: 4,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextTertiary,
              ),
              filled: true,
              fillColor: AppColors.darkSurfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.darkBorder,
                ),
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
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _addComment,
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text('Add Comment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // RESOLUTION NOTES
  // ------------------------------------------------------------

  Widget _buildResolutionNotes() {
    return _buildSectionCard(
      title: 'Resolution Notes',
      icon: Icons.task_alt_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add details about how the complaint was resolved.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _resolutionController,
            maxLines: 5,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Enter resolution details...',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextTertiary,
              ),
              filled: true,
              fillColor: AppColors.darkSurfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.darkBorder,
                ),
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
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _saveResolutionNotes,
            icon: const Icon(Icons.save_outlined, size: 18),
            label: const Text('Save Resolution Notes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ACTION BUTTONS
  // ------------------------------------------------------------

  Widget _buildActionButtons() {
    final isResolved = _currentStatus == 'Resolved';
    final isClosed = _currentStatus == 'Closed';

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        OutlinedButton.icon(
          onPressed: _showUpdateStatusDialog,
          icon: const Icon(Icons.sync_alt_rounded),
          label: const Text('Update Status'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.secondary,
            side: BorderSide(
              color: AppColors.secondary.withValues(alpha: 0.6),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        if (!isResolved && !isClosed)
          ElevatedButton.icon(
            onPressed: _showResolveDialog,
            icon: const Icon(Icons.check_circle_outline_rounded),
            label: const Text('Mark as Resolved'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------------
  // CONTENT
  // ------------------------------------------------------------

  Widget _buildContent(bool desktop) {
    if (desktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComplaintHeader(),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildDescription(),
                    const SizedBox(height: 18),
                    _buildTimeline(),
                    const SizedBox(height: 18),
                    _buildComments(),
                    const SizedBox(height: 18),
                    _buildResolutionNotes(),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildStudentInformation(),
                    const SizedBox(height: 18),
                    _buildComplaintInformation(),
                    const SizedBox(height: 18),
                    _buildAssignment(),
                    const SizedBox(height: 18),
                    _buildAttachments(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionButtons(),
        ],
      );
    }

    return Column(
      children: [
        _buildComplaintHeader(),
        const SizedBox(height: 18),
        _buildStudentInformation(),
        const SizedBox(height: 18),
        _buildComplaintInformation(),
        const SizedBox(height: 18),
        _buildDescription(),
        const SizedBox(height: 18),
        _buildTimeline(),
        const SizedBox(height: 18),
        _buildAssignment(),
        const SizedBox(height: 18),
        _buildAttachments(),
        const SizedBox(height: 18),
        _buildComments(),
        const SizedBox(height: 18),
        _buildResolutionNotes(),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildActionButtons(),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Complaint Details',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Update Status',
            onPressed: _showUpdateStatusDialog,
            icon: const Icon(Icons.sync_alt_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth >= 1000;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: desktop ? 32 : 16,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1440,
                  ),
                  child: _buildContent(desktop),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}