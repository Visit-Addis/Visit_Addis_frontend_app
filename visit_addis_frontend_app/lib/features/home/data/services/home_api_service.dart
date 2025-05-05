import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeApiService {
  static const String _baseUrl = 'https://visit-addis.onrender.com/api/v1';

  /// Fetches a list of featured attractions from the backend.
  static Future<List<Attraction>> fetchFeaturedAttractions() async {
    final response = await http.get(Uri.parse('$_baseUrl/attraction'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Attraction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load featured attractions');
    }
  }

  Future<String?> fetchUserName() async {
  final token = await TokenManager.getToken();
  if (token == null) return null;

  final response = await http.get(
    Uri.parse('https://visit-addis.onrender.com/api/v1/profile'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['userName'] ?? ''; // Return the userName
  } else {
    print('Failed to load profile data. Status: ${response.statusCode}');
    return null;
  }
}


  Future<List<Map<String, dynamic>>> getPopularRestaurants() async {
  final token = await TokenManager.getToken();

  final url = Uri.parse('https://visit-addis.onrender.com/api/v1/restaurant');
  final response = await http.get(url);

  if (response.statusCode != 200) throw Exception('Failed to load restaurants');

  final List data = json.decode(response.body);
  List<Map<String, dynamic>> popularRestaurants = [];

  for (var restaurant in data) {
    final id = restaurant['id'];
    final detailUrl = Uri.parse('https://visit-addis.onrender.com/api/v1/restaurant/$id');
    final detailResponse = await http.get(detailUrl, headers: {
      'Authorization': 'Bearer $token',
    });

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      popularRestaurants.add({
        'name': detailData['name'],
        'location': detailData['location'],
        'imageUrl': (detailData['images'] != null && detailData['images'].isNotEmpty)
            ? detailData['images'][0]['url']
            : null,
        'rating': detailData['averageRating'] ?? 0,
        'category': 'Restaurant',
      });
    }
  }

  return popularRestaurants;
}

}

class Attraction {
  final String name;
  final String category;
  final String? imageUrl;

  Attraction({
    required this.name,
    required this.category,
    this.imageUrl,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    String? firstImage;
    if (json['images'] != null && json['images'] is List && json['images'].isNotEmpty) {
      firstImage = json['images'][0]['url'];
    }

    return Attraction(
      name: json['name'] ?? 'No Name',
      category: json['category'] ?? 'Unknown',
      imageUrl: firstImage,
    );
  }
}


class TokenManager {
  static const _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}