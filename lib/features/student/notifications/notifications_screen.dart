import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/responsive/responsive.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      id: '1',
      title: 'Complaint status updated',
      message: 'Your complaint #US-1003 is now In Progress.',
      time: '10 minutes ago',
      icon: Icons.sync_rounded,
      iconColor: AppColors.info,
      complaintNumber: '#US-1003',
      isRead: false,
    ),
    _NotificationItem(
      id: '2',
      title: 'Complaint assigned',
      message:
      'Your complaint #US-1003 has been assigned to IT Support Department.',
      time: '1 hour ago',
      icon: Icons.person_outline_rounded,
      iconColor: AppColors.assigned,
      complaintNumber: '#US-1003',
      isRead: false,
    ),
    _NotificationItem(
      id: '3',
      title: 'Complaint under review',
      message:
      'Your complaint #US-1000 is currently being reviewed.',
      time: 'Yesterday',
      icon: Icons.rate_review_outlined,
      iconColor: AppColors.underReview,
      complaintNumber: '#US-1000',
      isRead: true,
    ),
    _NotificationItem(
      id: '4',
      title: 'Complaint resolved',
      message:
      'Your complaint #US-1001 has been resolved.',
      time: '3 days ago',
      icon: Icons.check_circle_outline_rounded,
      iconColor: AppColors.success,
      complaintNumber: '#US-1001',
      isRead: true,
    ),
    _NotificationItem(
      id: '5',
      title: 'Complaint submitted',
      message:
      'Your complaint #US-1002 was submitted successfully.',
      time: '4 days ago',
      icon: Icons.assignment_turned_in_outlined,
      iconColor: AppColors.primarySurface,
      complaintNumber: '#US-1002',
      isRead: true,
    ),
  ];

  int get _unreadCount {
    return _notifications
        .where((notification) => !notification.isRead)
        .length;
  }

  void _markAllAsRead() {
    setState(() {
      for (final notification in _notifications) {
        notification.isRead = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'All notifications marked as read.',
        ),
      ),
    );
  }

  void _openNotification(
      _NotificationItem notification,
      ) {
    setState(() {
      notification.isRead = true;
    });

    if (notification.complaintNumber != null) {
      context.push(
        '/student/complaint-details?number=${Uri.encodeComponent(notification.complaintNumber!)}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: AppColors.primarySurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(width: 4),
        ],
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
                maxWidth: 1000,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 18),
                  _buildNotificationList(),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: 0.10,
            ),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: AppColors.primarySurface,
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _unreadCount == 0
                      ? 'You are all caught up'
                      : 'You have $_unreadCount unread '
                      '${_unreadCount == 1 ? 'notification' : 'notifications'}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Stay updated with your complaint activity.',
                  style: AppTextStyles.bodyMedium.copyWith(
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

  Widget _buildNotificationList() {
    if (_notifications.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        for (int index = 0;
        index < _notifications.length;
        index++) ...[
          _buildNotificationCard(
            _notifications[index],
          ),
          if (index != _notifications.length - 1)
            const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildNotificationCard(
      _NotificationItem notification,
      ) {
    return Material(
      // Same dark purple style as the finalized My Complaints cards.
      color: AppColors.darkSurface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () {
          _openNotification(notification);
        },
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: notification.iconColor.withValues(
                    alpha: 0.14,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  notification.icon,
                  color: notification.iconColor,
                  size: 23,
                ),
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 9,
                            height: 9,
                            margin: const EdgeInsets.only(
                              left: 8,
                              top: 5,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.primarySurface,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.message,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 10,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: AppColors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              notification.time,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        if (notification.complaintNumber != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '•',
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                notification.complaintNumber!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.darkTextTertiary,
                size: 20,
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
        vertical: 50,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primarySurface,
              size: 34,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You will see complaint updates and other important notifications here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// NOTIFICATION MODEL
// -----------------------------------------------------------------------------

class _NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconColor;
  final String? complaintNumber;
  bool isRead;

  _NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.complaintNumber,
    required this.isRead,
  });
}