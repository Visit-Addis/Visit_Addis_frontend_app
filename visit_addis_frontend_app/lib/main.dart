import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_addis_frontend_app/features/hotels/data/services/hotel_service.dart';
import 'package:visit_addis_frontend_app/features/hotels/presentation/bloc/hotel_bloc.dart';

import 'app/routes.dart';
import 'features/attraction/bloc/attraction_bloc.dart'; // Import your AttractionCubit
import 'features/attraction/data/services/api_service.dart'; // Import ApiService
import 'features/auth/data/services/api_service.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/bloc/register_bloc.dart';
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
          create: (context) => LoginBloc(AuthService(APIService())),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(AuthService(APIService())),
        ),
        BlocProvider(
          create: (context) =>
              AttractionCubit(ApiService()), // Provide AttractionCubit here
        ),
        BlocProvider(
          create: (context) =>
              HotelCubit(HotelsApiService()), // Provide AttractionCubit here
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
