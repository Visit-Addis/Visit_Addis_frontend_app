import 'package:flutter/material.dart';
import 'package:visit_addis_frontend_app/features/attraction/presentation/attraction_detail.dart';
import 'package:visit_addis_frontend_app/features/attraction/presentation/attraction_list.dart';
import 'package:visit_addis_frontend_app/features/hotels/presentation/pages/hotel_detail.dart';
import 'package:visit_addis_frontend_app/features/hotels/presentation/pages/hotel_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visit Addis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/attractions/detail',
      routes: {
        '/hotels': (context) => const HotelList(),
        '/hotels/detail': (context) => const HotelDetail(),
        '/attractions': (context) => const AttractionList(),
        '/attractions/detail': (context) => const AttractionDetail(),
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('Page not found!'))),
        );
      },
    );
  }
}
