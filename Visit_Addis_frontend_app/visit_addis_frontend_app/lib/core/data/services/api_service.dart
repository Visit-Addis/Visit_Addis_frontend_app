import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://visit-addis-backend.onrender.com'; // Update with your actual backend URL
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make PUT request: $e');
    }
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make DELETE request: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }

  void dispose() {
    _client.close();
  }
} 