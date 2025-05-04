import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user.dart';
import 'api_service.dart';

class AuthService {
  final APIService apiService;

  AuthService(this.apiService);

  Future<bool> register(User user) {
    return apiService.registerUser(user);
  }

  Future<void> login(String email, String password) async {
    const String baseUrl = 'https://visit-addis.onrender.com/api/v1/auth';
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      print(data);
      print(token);
      return;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
