import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/events/presentation/screens/events_screen.dart';
import '../../features/events/presentation/screens/event_details_screen.dart';
import '../../features/intro/intro_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String events = '/events';
  static const String eventDetails = '/event-details';
  static const String intro = '/intro';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case events:
        return MaterialPageRoute(builder: (_) => const EventsScreen());
      case eventDetails:
        return MaterialPageRoute(
          builder: (_) => const EventDetailsScreen(),
          settings: settings,
        );
      case intro:
        return MaterialPageRoute(builder: (_) => const IntroPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 