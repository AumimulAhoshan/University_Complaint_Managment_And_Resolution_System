
import 'package:go_router/go_router.dart';
import '../../features/student/profile/profile_screen.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/student/complaints/complaint_details/complaint_details_screen.dart';
import '../../features/student/complaints/my_complaints/my_complaints_screen.dart';
import '../../features/student/complaints/submit_complaint/submit_complaint_screen.dart';
import '../../features/student/dashboard/student_dashboard_screen.dart';
import '../../features/student/notifications/notifications_screen.dart';
import '../../features/auth/register/register_screen.dart';
import '../../features/auth/forgot_password/forgot_password_screen.dart';
import '../../features/auth/reset_password/reset_password_screen.dart';
import '../../features/staff/dashboard/staff_dashboard_screen.dart';
import '../../features/staff/complaints/assigned_complaints_screen.dart';
import '../../features/staff/complaints/staff_complaint_details_screen.dart';
import '../../features/staff/notifications/staff_notifications_screen.dart';
import '../../features/staff/profile/staff_profile_screen.dart';
import '../../features/admin/dashboard/admin_dashboard_screen.dart';
import '../../features/admin/complaints/all_complaints_screen.dart';
import '../../features/admin/complaints/admin_complaint_details_screen.dart';
import '../../features/admin/users/user_management_screen.dart';
import '../../features/admin/staff/staff_management_screen.dart';
import '../../features/admin/departments/department_management_screen.dart';
import '../../features/admin/categories/category_management_screen.dart';
import '../../features/admin/reports/reports_analytics_screen.dart';
import '../../features/admin/notifications/admin_notifications_screen.dart';
import '../../features/admin/profile/admin_profile_screen.dart';






final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // -------------------------------------------------------------------------
    // SPLASH
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

    // -------------------------------------------------------------------------
    // AUTH
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      name: 'reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    // -------------------------------------------------------------------------
    // STUDENT DASHBOARD
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) {
        return const StudentDashboardScreen();
      },
    ),

    // -------------------------------------------------------------------------
    // STUDENT - SUBMIT COMPLAINT
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/student/submit-complaint',
      name: 'submit-complaint',
      builder: (context, state) {
        return const SubmitComplaintScreen();
      },
    ),

    // -------------------------------------------------------------------------
    // STUDENT - MY COMPLAINTS
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/student/my-complaints',
      name: 'my-complaints',
      builder: (context, state) {
        return const MyComplaintsScreen();
      },
    ),

    // -------------------------------------------------------------------------
    // STUDENT - NOTIFICATIONS
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/student/notifications',
      name: 'notifications',
      builder: (context, state) {
        return const NotificationsScreen();
      },
    ),
    GoRoute(
      path: '/student/profile',
      name: 'student-profile',
      builder: (context, state) {
        return const ProfileScreen();
      },
    ),

    // -------------------------------------------------------------------------
    // STUDENT - COMPLAINT DETAILS
    // -------------------------------------------------------------------------
    GoRoute(
      path: '/student/complaint-details',
      name: 'complaint-details',
      builder: (context, state) {
        final complaintNumber =
            state.uri.queryParameters['number'] ??
                '#US-1003';

        return ComplaintDetailsScreen(
          complaintNumber: complaintNumber,
        );
      },
    ),
    GoRoute(
      path: '/admin',
      name: 'admin-dashboard',
      builder: (context, state) {
        return const AdminDashboardScreen();
      },
    ),
    GoRoute(
      path: '/admin/complaints',
      name: 'admin-complaints',
      builder: (context, state) {
        return const AllComplaintsScreen();
      },
    ),
    GoRoute(
      path: '/admin/complaint-details',
      name: 'admin-complaint-details',
      builder: (context, state) {
        return AdminComplaintDetailsScreen(
          complaintNumber: state.uri.queryParameters['number'],
        );
      },
    ),
    GoRoute(
      path: '/admin/users',
      name: 'admin-users',
      builder: (context, state) => const UserManagementScreen(),
    ),
    GoRoute(
      path: '/admin/staff',
      name: 'admin-staff',
      builder: (context, state) => const StaffManagementScreen(),
    ),
    GoRoute(
      path: '/admin/departments',
      name: 'admin-departments',
      builder: (context, state) => const DepartmentManagementScreen(),
    ),
    GoRoute(
      path: '/admin/categories',
      name: 'admin-categories',
      builder: (context, state) => const CategoryManagementScreen(),
    ),
    GoRoute(
      path: '/admin/reports',
      name: 'admin-reports',
      builder: (context, state) => const ReportsAnalyticsScreen(),
    ),
    GoRoute(
      path: '/admin/notifications',
      name: 'admin-notifications',
      builder: (context, state) => const AdminNotificationsScreen(),
    ),
    GoRoute(
      path: '/admin/profile',
      name: 'admin-profile',
      builder: (context, state) => const AdminProfileScreen(),
    ),
    GoRoute(
      path: '/staff',
      name: 'staff-dashboard',
      builder: (context, state) => const StaffDashboardScreen(),
    ),
    GoRoute(
      path: '/staff/complaints',
      name: 'staff-complaints',
      builder: (context, state) {
        return AssignedComplaintsScreen(
          initialStatus: state.uri.queryParameters['status'],
        );
      },
    ),
    GoRoute(
      path: '/staff/complaint-details',
      name: 'staff-complaint-details',
      builder: (context, state) {
        return StaffComplaintDetailsScreen(
          complaintNumber: state.uri.queryParameters['number'],
        );
      },
    ),
    GoRoute(
      path: '/staff/notifications',
      name: 'staff-notifications',
      builder: (context, state) {
        return const StaffNotificationsScreen();
      },
    ),
    GoRoute(
      path: '/staff/profile',
      name: 'staff-profile',
      builder: (context, state) {
        return const StaffProfileScreen();
      },
    ),
  ],
);

// -----------------------------------------------------------------------------
// PLACEHOLDER SCREEN
// -----------------------------------------------------------------------------

