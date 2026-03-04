import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/login_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../pages/notifications_page.dart';

class RouteConfig {
  static late GoRouter router;

  static void init() {
    router = GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/forgot-password',
          name: 'forgot_password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          builder: (context, state) => const NotificationsPage(),
        ),
      ],
    );
  }
}
