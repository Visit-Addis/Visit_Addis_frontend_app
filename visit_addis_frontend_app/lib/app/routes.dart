import 'package:flutter/material.dart';

import '../../features/attraction/presentation/attraction_detail.dart';
import '../../features/attraction/presentation/attraction_list.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/events/presentation/screens/event_details_screen.dart';
import '../../features/events/presentation/screens/events_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/hotels/presentation/pages/hotel_detail.dart';
import '../../features/hotels/presentation/pages/hotel_list.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String events = '/events';
  static const String eventDetails = '/event-details';
  static const String home = '/home';
  static const String hotels = '/hotels';
  static const String hotelsDetails = '/hotels/details';
  static const String attractions = '/attractions';
  static const String attractionsDetails = '/attractions/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case events:
        return MaterialPageRoute(builder: (_) => const EventsScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case hotels:
        return MaterialPageRoute(builder: (_) => const HotelList());
      case hotelsDetails:
        final String? hotelId = settings.arguments as String?;
        if (hotelId == null) {
          return _errorRoute('Hotel ID is required for details');
        }
        return MaterialPageRoute(
            builder: (_) => HotelDetail(hotelId:hotelId)); // Pass hotelId
      case attractions:
        return MaterialPageRoute(builder: (_) => const AttractionList());
      
       case attractionsDetails:
        final String? attractionId = settings.arguments as String?;
        if (attractionId == null) {
          return _errorRoute('Attraction ID is required for details');
        }
        return MaterialPageRoute(builder: (_) => AttractionDetail(attractionId: attractionId)); 



      case eventDetails:
        final String? eventId = settings.arguments as String?;
        if (eventId == null) {
          return _errorRoute('Event ID is required for details');
        }
        return MaterialPageRoute(
            builder: (_) =>
                EventDetailsScreen()); // Pass eventId
      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
