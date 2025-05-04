import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/models/user.dart';

class APIService {
  final String baseUrl = 'https://visit-addis.onrender.com/api/v1/auth';

  Future<bool> registerUser(User user) async {
    final userJson = user.toJson(); // Serialize user to JSON
    print('User JSON: $userJson'); // Log the user JSON

    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userJson),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Registration failed: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false; // Registration failed
    }
  }
}
