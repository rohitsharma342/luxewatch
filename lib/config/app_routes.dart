import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/watch_details_screen.dart';
import '../screens/messaging_screen.dart';
import '../screens/profile_settings_screen.dart';
import '../models/watch_model.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String dashboard = '/dashboard';
  static const String watchDetails = '/watch-details';
  static const String messaging = '/messaging';
  static const String profileSettings = '/profile-settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen());
      case login:
        return _buildRoute(const LoginScreen());
      case registration:
        return _buildRoute(const RegistrationScreen());
      case dashboard:
        return _buildRoute(const DashboardScreen());
      case watchDetails:
        final watch = settings.arguments as WatchModel;
        return _buildRoute(WatchDetailsScreen(watch: watch));
      case messaging:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(MessagingScreen(
          sellerId: args['sellerId'],
          sellerName: args['sellerName'],
          watchName: args['watchName'],
        ));
      case profileSettings:
        return _buildRoute(const ProfileSettingsScreen());
      default:
        return _buildRoute(const SplashScreen());
    }
  }

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}