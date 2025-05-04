import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/routes.dart';
import 'features/auth/data/services/api_service.dart'; // Import your ApiService
import 'features/auth/data/services/auth_service.dart'; // Import your AuthService
import 'features/auth/presentation/bloc/login_bloc.dart'; // Import your LoginBloc
import 'features/auth/presentation/bloc/register_bloc.dart'; // Import your RegistrationBloc
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthService(ApiService())),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(
              AuthService(ApiService())), // Add RegistrationBloc here
        ),
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
        onGenerateRoute: AppRoutes.generateRoute,
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state.isLoggedIn ? HomeScreen() : LoginScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
