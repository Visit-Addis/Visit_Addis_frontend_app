import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../utils/auth_utils.dart';
import '../../data/models/hotels_model.dart';

class HotelsApiService {
  final String baseUrl = 'https://visit-addis.onrender.com/api/v1/restaurant';

  Future<List<Restaurant>> fetchHotels() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(response.body);
      // print(data);
      return data.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  Future<Restaurant> fetchHotelById(String id) async {
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
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load hotel details: ${response.body}');
    }
  }
}
