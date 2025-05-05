import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../utils/auth_utils.dart';
import '../../data/models/events_model.dart';

class EventsApiService {
  final String baseUrl = 'https://visit-addis.onrender.com/api/v1/event';

  // Fetch all events
  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  // Fetch single event by ID (includes details like averageRating and reviews)
  Future<Event> fetchEventById(String id) async {
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
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load event details: ${response.body}');
    }
  }
}
