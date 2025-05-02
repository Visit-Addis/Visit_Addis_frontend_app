import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'https://visit-addis-backend.onrender.com/api';
  final http.Client _client = http.Client();

  // Temporary mock data for testing
  Future<String> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock successful login for any non-empty credentials
    if (email.isNotEmpty && password.isNotEmpty) {
      return "mock_token_12345";
    }
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'];
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception('Please enter valid credentials');
    }
  }

  Future<String> register(String email, String password, String name) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock successful registration
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      return "mock_token_12345";
    }
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
        }),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['token'];
      } else {
        throw Exception('Registration failed');
      }
    } catch (e) {
      throw Exception('Please check your connection and try again');
    }
  }
} 