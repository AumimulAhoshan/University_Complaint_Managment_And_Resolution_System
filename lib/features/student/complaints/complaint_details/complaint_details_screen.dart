import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/responsive/responsive.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  final String complaintNumber;

  const ComplaintDetailsScreen({
    super.key,
    required this.complaintNumber,
  });

  @override
  State<ComplaintDetailsScreen> createState() =>
      _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  int _selectedRating = 0;

  bool _feedbackSubmitted = false;

  final TextEditingController _feedbackController =
  TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: const Text(
          'Complaint Details',
        ),
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
                maxWidth: 1100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 18),
                  _buildStatusCard(),
                  const SizedBox(height: 18),
                  _buildInformationSection(isDesktop),
                  const SizedBox(height: 18),
                  _buildDescriptionCard(),
                  const SizedBox(height: 18),
                  _buildTimelineCard(),
                  const SizedBox(height: 18),
                  _buildAssignmentCard(),
                  const SizedBox(height: 18),
                  _buildAttachmentsCard(),
                  const SizedBox(height: 18),
                  _buildCommentsCard(),
                  const SizedBox(height: 18),
                  _buildFeedbackCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppColors.primarySurface,
              size: 29,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.complaintNumber,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primarySurface,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Classroom Projector Not Working',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Submitted on October 02, 2026',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STATUS
  // ---------------------------------------------------------------------------

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(
                    alpha: 0.15,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.sync_rounded,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'In Progress',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Your complaint is currently being handled by the assigned team.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INFORMATION
  // ---------------------------------------------------------------------------

  Widget _buildInformationSection(bool isDesktop) {
    final children = [
      _buildInfoItem(
        icon: Icons.category_outlined,
        title: 'Category',
        value: 'IT & Equipment',
      ),
      _buildInfoItem(
        icon: Icons.flag_outlined,
        title: 'Priority',
        value: 'High',
        valueColor: AppColors.highPriority,
      ),
      _buildInfoItem(
        icon: Icons.location_on_outlined,
        title: 'Location',
        value: 'Building A, Room 302',
      ),
      _buildInfoItem(
        icon: Icons.calendar_today_outlined,
        title: 'Submitted',
        value: 'October 02, 2026',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complaint Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          if (isDesktop)
            Row(
              children: [
                for (int i = 0; i < children.length; i++) ...[
                  Expanded(
                    child: children[i],
                  ),
                  if (i != children.length - 1)
                    const SizedBox(width: 12),
                ],
              ],
            )
          else
            Column(
              children: [
                for (int i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i != children.length - 1)
                    const SizedBox(height: 10),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primarySurface,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DESCRIPTION
  // ---------------------------------------------------------------------------

  Widget _buildDescriptionCard() {
    return _buildSectionCard(
      title: 'Description',
      icon: Icons.description_outlined,
      child: const Text(
        'The projector in Building A, Room 302 is not displaying anything. '
            'The device turns on, but no image appears on the screen. '
            'This issue is affecting our regular classroom presentations and lectures.',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.white,
          height: 1.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STATUS TIMELINE
  // ---------------------------------------------------------------------------

  Widget _buildTimelineCard() {
    return _buildSectionCard(
      title: 'Status History',
      icon: Icons.timeline_rounded,
      child: Column(
        children: [
          _buildTimelineItem(
            title: 'Complaint Submitted',
            description: 'Complaint was submitted successfully.',
            date: 'Oct 02, 2026 • 09:15 AM',
            icon: Icons.send_rounded,
            color: AppColors.submitted,
            isLast: false,
          ),
          _buildTimelineItem(
            title: 'Under Review',
            description:
            'The complaint was reviewed by the university team.',
            date: 'Oct 02, 2026 • 10:40 AM',
            icon: Icons.rate_review_outlined,
            color: AppColors.underReview,
            isLast: false,
          ),
          _buildTimelineItem(
            title: 'Assigned',
            description: 'Assigned to the IT Support Department.',
            date: 'Oct 02, 2026 • 12:20 PM',
            icon: Icons.person_outline_rounded,
            color: AppColors.secondary,
            isLast: false,
          ),
          _buildTimelineItem(
            title: 'In Progress',
            description:
            'The assigned team has started working on the issue.',
            date: 'Oct 02, 2026 • 02:00 PM',
            icon: Icons.sync_rounded,
            color: AppColors.inProgress,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String description,
    required String date,
    required IconData icon,
    required Color color,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 42,
          child: Column(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(
                    alpha: 0.15,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 19,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 58,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  color: AppColors.darkBorder,
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ASSIGNMENT
  // ---------------------------------------------------------------------------

  Widget _buildAssignmentCard() {
    return _buildSectionCard(
      title: 'Assigned Team',
      icon: Icons.groups_outlined,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.computer_rounded,
                color: AppColors.primarySurface,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IT Support Department',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Assigned Staff: Ahmed Rahman',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ATTACHMENTS
  // ---------------------------------------------------------------------------

  Widget _buildAttachmentsCard() {
    return _buildSectionCard(
      title: 'Attachments',
      icon: Icons.attach_file_rounded,
      child: Column(
        children: [
          _buildAttachmentItem(
            fileName: 'projector_issue.jpg',
            fileType: 'JPG Image',
            icon: Icons.image_outlined,
          ),
          const SizedBox(height: 10),
          _buildAttachmentItem(
            fileName: 'classroom_photo.png',
            fileType: 'PNG Image',
            icon: Icons.image_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem({
    required String fileName,
    required String fileType,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: AppColors.primarySurface,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  fileType,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // File preview/download will be
              // connected to the backend later.
            },
            icon: const Icon(
              Icons.open_in_new_rounded,
              color: AppColors.primarySurface,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // COMMENTS
  // ---------------------------------------------------------------------------

  Widget _buildCommentsCard() {
    return _buildSectionCard(
      title: 'Comments',
      icon: Icons.chat_bubble_outline_rounded,
      child: Column(
        children: [
          _buildCommentItem(
            name: 'Ahmed Rahman',
            role: 'IT Support',
            message:
            'We have received the complaint and are checking the projector.',
            time: 'Today, 02:15 PM',
            isStaff: true,
          ),
          const SizedBox(height: 12),
          _buildCommentItem(
            name: 'You',
            role: 'Student',
            message: 'Thank you. The projector is still not working.',
            time: 'Today, 02:30 PM',
            isStaff: false,
          ),
          const SizedBox(height: 16),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentItem({
    required String name,
    required String role,
    required String message,
    required String time,
    required bool isStaff,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isStaff ? AppColors.primary : AppColors.primaryDark,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isStaff
                  ? Icons.support_agent_rounded
                  : Icons.person_outline_rounded,
              color: AppColors.primarySurface,
              size: 19,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        role,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.primarySurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // COMMENT INPUT
  // ---------------------------------------------------------------------------

  Widget _buildCommentInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: AppColors.primarySurface,
            cursorWidth: 2,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.chat_outlined,
                color: AppColors.darkTextSecondary,
                size: 20,
              ),
              filled: true,
              fillColor: AppColors.primaryDark,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide(
                  color: AppColors.primary.withValues(
                    alpha: 0.75,
                  ),
                  width: 1.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: AppColors.primarySurface,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: AppColors.primarySurface,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(17),
          ),
          child: IconButton(
            onPressed: () {
              // Comment API will be added later.
            },
            icon: const Icon(
              Icons.send_rounded,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // FEEDBACK
  // ---------------------------------------------------------------------------

  Widget _buildFeedbackCard() {
    return _buildSectionCard(
      title: 'Feedback',
      icon: Icons.star_outline_rounded,
      child: _feedbackSubmitted
          ? _buildSubmittedFeedback()
          : _buildFeedbackForm(),
    );
  }

  Widget _buildFeedbackForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How was your experience?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'You can provide feedback after your complaint is resolved.',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          // Rating
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 2,
              children: List.generate(
                5,
                    (index) {
                  final rating = index + 1;
                  final isSelected = rating <= _selectedRating;

                  return IconButton(
                    tooltip: '$rating star${rating == 1 ? '' : 's'}',
                    onPressed: () {
                      setState(() {
                        _selectedRating = rating;
                      });
                    },
                    icon: Icon(
                      isSelected
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: AppColors.primarySurface,
                      size: 34,
                    ),
                  );
                },
              ),
            ),
          ),

          if (_selectedRating > 0) ...[
            const SizedBox(height: 2),
            Center(
              child: Text(
                _getRatingText(_selectedRating),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primarySurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],

          const SizedBox(height: 18),

          // Feedback text
          TextField(
            controller: _feedbackController,
            maxLines: 4,
            minLines: 4,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
              height: 1.45,
            ),
            cursorColor: AppColors.primarySurface,
            decoration: InputDecoration(
              hintText: 'Tell us about your experience...',
              hintStyle: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide(
                  color: AppColors.surface.withValues(
                    alpha: 0.35,
                  ),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: AppColors.surface,
                  width: 1.4,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed:
              _selectedRating == 0 ? null : _submitFeedback,
              icon: const Icon(
                Icons.send_rounded,
                size: 18,
              ),
              label: const Text(
                'Submit Feedback',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySurface,
                foregroundColor: AppColors.textPrimary,
                disabledBackgroundColor: AppColors.primaryDark,
                disabledForegroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmittedFeedback() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(
                alpha: 0.15,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.success,
              size: 30,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Thank You for Your Feedback!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your feedback has been recorded successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.darkTextSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                  (index) {
                return Icon(
                  index < _selectedRating
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: AppColors.primarySurface,
                  size: 25,
                );
              },
            ),
          ),
          if (_feedbackController.text.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                _feedbackController.text.trim(),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.darkTextSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Very dissatisfied';
      case 2:
        return 'Dissatisfied';
      case 3:
        return 'Neutral';
      case 4:
        return 'Satisfied';
      case 5:
        return 'Very satisfied';
      default:
        return '';
    }
  }

  void _submitFeedback() {
    if (_selectedRating == 0) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _feedbackSubmitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Feedback submitted successfully.',
        ),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // COMMON SECTION CARD
  // ---------------------------------------------------------------------------

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primarySurface,
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}