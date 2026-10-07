import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class StaffNotificationsScreen extends StatefulWidget {
  const StaffNotificationsScreen({super.key});

  @override
  State<StaffNotificationsScreen> createState() =>
      _StaffNotificationsScreenState();
}

class _StaffNotificationsScreenState
    extends State<StaffNotificationsScreen> {
  final List<_StaffNotification> _notifications = [
    _StaffNotification(
      title: 'New Complaint Assigned',
      message:
      'A new IT & Technical complaint has been assigned to you.',
      time: '10 minutes ago',
      icon: Icons.assignment_outlined,
      color: AppColors.assigned,
      unread: true,
      complaintNumber: 'CMP-2026-0018',
    ),
    _StaffNotification(
      title: 'Complaint Requires Attention',
      message:
      'The student has added a new comment to complaint CMP-2026-0015.',
      time: '35 minutes ago',
      icon: Icons.comment_outlined,
      color: AppColors.info,
      unread: true,
      complaintNumber: 'CMP-2026-0015',
    ),
    _StaffNotification(
      title: 'Complaint Marked as High Priority',
      message:
      'Complaint CMP-2026-0012 has been marked as high priority.',
      time: '1 hour ago',
      icon: Icons.priority_high_rounded,
      color: AppColors.highPriority,
      unread: true,
      complaintNumber: 'CMP-2026-0012',
    ),
    _StaffNotification(
      title: 'Complaint Resolved',
      message:
      'Complaint CMP-2026-0009 has been successfully resolved.',
      time: '3 hours ago',
      icon: Icons.check_circle_outline_rounded,
      color: AppColors.resolved,
      unread: false,
      complaintNumber: 'CMP-2026-0009',
    ),
    _StaffNotification(
      title: 'New Student Comment',
      message:
      'A student has replied to your comment on complaint CMP-2026-0007.',
      time: 'Yesterday',
      icon: Icons.chat_bubble_outline_rounded,
      color: AppColors.underReview,
      unread: false,
      complaintNumber: 'CMP-2026-0007',
    ),
    _StaffNotification(
      title: 'Complaint Deadline Reminder',
      message:
      'Complaint CMP-2026-0005 is approaching its resolution deadline.',
      time: 'Yesterday',
      icon: Icons.access_time_rounded,
      color: AppColors.warning,
      unread: false,
      complaintNumber: 'CMP-2026-0005',
    ),
  ];

  int get _unreadCount =>
      _notifications.where((notification) => notification.unread).length;

  void _markAllAsRead() {
    setState(() {
      for (final notification in _notifications) {
        notification.unread = false;
      }
    });

    _showMessage('All notifications marked as read.');
  }

  void _markAsRead(_StaffNotification notification) {
    if (!notification.unread) return;

    setState(() {
      notification.unread = false;
    });
  }

  void _openNotification(_StaffNotification notification) {
    _markAsRead(notification);

    if (notification.complaintNumber != null) {
      context.go(
        '/staff/complaint-details?number=${Uri.encodeComponent(notification.complaintNumber!)}',
      );
    }
  }

  void _showMessage(String message) {
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.secondary,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _unreadCount == 0
                      ? 'You are all caught up.'
                      : '$_unreadCount unread notification'
                      '${_unreadCount == 1 ? '' : 's'}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Mark all read',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
      _StaffNotification notification,
      ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openNotification(notification),
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: notification.unread
                ? AppColors.darkSurface
                : AppColors.darkSurfaceVariant,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: notification.unread
                  ? AppColors.secondary.withValues(alpha: 0.35)
                  : AppColors.darkBorder,
            ),
            boxShadow: [
              if (notification.unread)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 7),
                ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: notification.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      notification.icon,
                      color: notification.color,
                      size: 24,
                    ),
                  ),
                  if (notification.unread)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.darkSurface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.darkTextPrimary,
                              fontWeight: notification.unread
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                        if (notification.unread)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      notification.message,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextSecondary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 15,
                          color: AppColors.darkTextTertiary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          notification.time,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextTertiary,
                          ),
                        ),
                        const Spacer(),
                        if (notification.complaintNumber != null)
                          Text(
                            notification.complaintNumber!,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.secondary,
              size: 36,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No Notifications',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You currently have no new notifications.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool desktop) {
    if (_notifications.isEmpty) {
      return _buildEmptyState();
    }

    if (desktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _notifications.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 2.15,
        ),
        itemBuilder: (context, index) {
          return _buildNotificationCard(_notifications[index]);
        },
      );
    }

    return Column(
      children: _notifications
          .map(
            (notification) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildNotificationCard(notification),
        ),
      )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        title: Text(
          'Staff Notifications',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (_unreadCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$_unreadCount unread',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildContent(desktop),
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
}

class _StaffNotification {
  _StaffNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
    required this.unread,
    this.complaintNumber,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color color;
  bool unread;
  final String? complaintNumber;
}