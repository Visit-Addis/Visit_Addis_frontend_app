import 'package:flutter/material.dart';
import 'package:visit_addis_frontend_app/features/home/presentation/home_screen.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/events/presentation/providers/events_provider.dart';
import 'app/routes.dart';
import 'features/attraction/presentation/attraction_detail.dart';
import 'features/attraction/presentation/attraction_list.dart';
import 'features/hotels/presentation/pages/hotel_detail.dart';
import 'features/hotels/presentation/pages/hotel_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
      ],
      child: MaterialApp(
        title: 'Visit Addis',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        // Combined routing solution
        onGenerateRoute: (settings) {
          // Try the AppRoutes first
          final route = AppRoutes.generateRoute(settings);
          if (route != null) return route;
          
          // Fall back to manual routes
          switch (settings.name) {
            case "/":
                return MaterialPageRoute(builder: (_) => const HomeScreen());
            case '/hotels':
              return MaterialPageRoute(builder: (_) => const HotelList());
            case '/hotels/detail':
              return MaterialPageRoute(builder: (_) => const HotelDetail());
            case '/attractions':
              return MaterialPageRoute(builder: (_) => const AttractionList());
            case 'attractions/detail':
              return MaterialPageRoute(builder: (_) => const AttractionDetail());
            default:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Page not found!')),
                ),
              );
          }
        },
        initialRoute: '/', 
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

