import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/events/presentation/providers/events_provider.dart';
import 'app/routes.dart';
import 'theme/app_theme.dart';

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
        theme: greenTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: '/intro',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
