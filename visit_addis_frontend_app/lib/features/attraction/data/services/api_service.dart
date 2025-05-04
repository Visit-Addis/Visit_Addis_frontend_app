import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../utils/auth_utils.dart'; //
import '../models/attraction_models.dart';

class ApiService {
  final String baseUrl = 'https://visit-addis.onrender.com/api/v1/attraction';

  Future<List<Attraction>> fetchAttractions() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attraction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attractions');
    }
  }

  Future<Attraction> fetchAttractionById(String id) async {
    final token = await getAuthToken();

    if (token == null) {
      throw Exception('Authentication token is missing.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Attraction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load attraction details: ${response.body}');
    }
  }
}
