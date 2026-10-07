import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState
    extends State<AdminNotificationsScreen> {
  final List<_AdminNotification> _notifications = [
    _AdminNotification(
      id: '1',
      title: 'New complaint submitted',
      message:
      'A new complaint has been submitted by Aumimul Ahosan regarding Wi-Fi connectivity.',
      time: '10 minutes ago',
      type: _NotificationType.complaint,
      isRead: false,
      complaintNumber: 'CMP-2026-00486',
    ),
    _AdminNotification(
      id: '2',
      title: 'Complaint overdue',
      message:
      'Complaint CMP-2026-00481 has exceeded its expected resolution time.',
      time: '35 minutes ago',
      type: _NotificationType.overdue,
      isRead: false,
      complaintNumber: 'CMP-2026-00481',
    ),
    _AdminNotification(
      id: '3',
      title: 'New staff member added',
      message:
      'A new staff member has been added to the Information Technology department.',
      time: '1 hour ago',
      type: _NotificationType.staff,
      isRead: false,
    ),
    _AdminNotification(
      id: '4',
      title: 'Complaint resolved',
      message:
      'Complaint CMP-2026-00484 has been marked as resolved by the assigned staff member.',
      time: '2 hours ago',
      type: _NotificationType.resolved,
      isRead: true,
      complaintNumber: 'CMP-2026-00484',
    ),
    _AdminNotification(
      id: '5',
      title: 'New user registered',
      message:
      'A new student account has been registered in the UniServa system.',
      time: '3 hours ago',
      type: _NotificationType.user,
      isRead: true,
    ),
    _AdminNotification(
      id: '6',
      title: 'High priority complaint',
      message:
      'A high-priority complaint has been submitted regarding classroom facilities.',
      time: '5 hours ago',
      type: _NotificationType.warning,
      isRead: true,
      complaintNumber: 'CMP-2026-00482',
    ),
    _AdminNotification(
      id: '7',
      title: 'System update',
      message:
      'The UniServa complaint management system has been updated successfully.',
      time: 'Yesterday',
      type: _NotificationType.system,
      isRead: true,
    ),
    _AdminNotification(
      id: '8',
      title: 'Department updated',
      message:
      'The Information Technology department information was updated.',
      time: 'Yesterday',
      type: _NotificationType.department,
      isRead: true,
    ),
  ];

  int get _unreadCount =>
      _notifications.where((notification) => !notification.isRead).length;

  void _markAsRead(_AdminNotification notification) {
    if (notification.isRead) {
      return;
    }

    setState(() {
      notification.isRead = true;
    });
  }

  void _markAllAsRead() {
    if (_unreadCount == 0) {
      return;
    }

    setState(() {
      for (final notification in _notifications) {
        notification.isRead = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All notifications marked as read.'),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  void _handleNotificationTap(_AdminNotification notification) {
    _markAsRead(notification);

    if (notification.complaintNumber != null) {
      context.go(
        '/admin/complaint-details?number=${Uri.encodeComponent(notification.complaintNumber!)}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Mark all read',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.secondaryLight,
                ),
              ),
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1024;
          final isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

          final horizontalPadding = isDesktop
              ? 32.0
              : isTablet
              ? 24.0
              : 16.0;

          final maxWidth = isDesktop ? 1200.0 : double.infinity;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _notifications.isEmpty
                          ? _buildEmptyState()
                          : _buildNotificationList(
                        isDesktop: isDesktop,
                        isTablet: isTablet,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
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
              color: AppColors.secondary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.notifications_rounded,
              color: AppColors.secondaryLight,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Notifications',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _unreadCount == 0
                      ? 'You are all caught up.'
                      : '$_unreadCount unread notification${_unreadCount == 1 ? '' : 's'}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (_unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '$_unreadCount',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationList({
    required bool isDesktop,
    required bool isTablet,
  }) {
    if (isDesktop) {
      return GridView.builder(
        padding: const EdgeInsets.only(bottom: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.35,
        ),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationCard(_notifications[index]);
        },
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      itemCount: _notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildNotificationCard(_notifications[index]);
      },
    );
  }

  Widget _buildNotificationCard(_AdminNotification notification) {
    final iconData = _iconForType(notification.type);
    final iconColor = _colorForType(notification.type);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleNotificationTap(notification),
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: notification.isRead
                ? AppColors.surfaceVariant
                : AppColors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: notification.isRead
                  ? AppColors.darkBorder
                  : AppColors.secondary.withValues(alpha: 0.45),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(
                  alpha: notification.isRead ? 0.08 : 0.14,
                ),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(
                iconData: iconData,
                color: iconColor,
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.darkTextPrimary,
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 9,
                            height: 9,
                            margin: const EdgeInsets.only(
                              left: 8,
                              top: 6,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryLight,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      notification.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextSecondary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 15,
                          color: AppColors.darkTextTertiary,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            notification.time,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.darkTextTertiary,
                            ),
                          ),
                        ),
                        if (notification.complaintNumber != null)
                          Text(
                            notification.complaintNumber!,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.secondaryLight,
                              fontWeight: FontWeight.w700,
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

  Widget _buildNotificationIcon({
    required IconData iconData,
    required Color color,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 520),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.secondaryLight,
                size: 38,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'No notifications',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You do not have any notifications at the moment.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(_NotificationType type) {
    switch (type) {
      case _NotificationType.complaint:
        return Icons.report_problem_rounded;
      case _NotificationType.overdue:
        return Icons.schedule_rounded;
      case _NotificationType.staff:
        return Icons.badge_rounded;
      case _NotificationType.resolved:
        return Icons.check_circle_rounded;
      case _NotificationType.user:
        return Icons.person_add_rounded;
      case _NotificationType.warning:
        return Icons.priority_high_rounded;
      case _NotificationType.system:
        return Icons.system_update_rounded;
      case _NotificationType.department:
        return Icons.account_balance_rounded;
    }
  }

  Color _colorForType(_NotificationType type) {
    switch (type) {
      case _NotificationType.complaint:
        return AppColors.info;
      case _NotificationType.overdue:
        return AppColors.error;
      case _NotificationType.staff:
        return AppColors.assigned;
      case _NotificationType.resolved:
        return AppColors.success;
      case _NotificationType.user:
        return AppColors.submitted;
      case _NotificationType.warning:
        return AppColors.warning;
      case _NotificationType.system:
        return AppColors.secondaryLight;
      case _NotificationType.department:
        return AppColors.primaryLight;
    }
  }
}

enum _NotificationType {
  complaint,
  overdue,
  staff,
  resolved,
  user,
  warning,
  system,
  department,
}

class _AdminNotification {
  _AdminNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
    this.complaintNumber,
  });

  final String id;
  final String title;
  final String message;
  final String time;
  final _NotificationType type;
  final String? complaintNumber;
  bool isRead;
}