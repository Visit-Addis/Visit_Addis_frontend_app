import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_addis_frontend_app/features/events/presentation/pages/event_details_screen.dart';
import 'package:visit_addis_frontend_app/features/events/presentation/screens/events_screen.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/services/auth_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        title: 'Visit Addis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/': (context) => const LoginScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterPage(),
          '/events': (context) => const EventsScreen(),
          '/event-details': (context) => const EventDetailsScreen(),
        },
      ),
    );
  }
}
