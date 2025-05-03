import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/routes.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/events/presentation/providers/events_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: true),
        ChangeNotifierProvider(create: (_) => EventsProvider(), lazy: true),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
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
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: authProvider.isAuthenticated
                ? AppRoutes.home
                : AppRoutes.login,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
