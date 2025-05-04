import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/event.dart';

class EventService {
  final String baseUrl = 'https://visit-addis-backend.onrender.com/api';
  final http.Client _client = http.Client();

  List<Event> _getMockEvents() {
    return [
      Event(
        id: '1',
        name: 'Ethiopian Jazz Night',
        description:
            'Experience the best of Ethiopian Jazz with live performances from local artists.',
        venue: 'African Jazz Village',
        date: DateTime.now().add(const Duration(days: 2)),
        category: 'Music',
        entryFee: 500.0,
        capacity: 200,
        imageUrl:
            'https://images.unsplash.com/photo-1511192336575-5a79af67a629',
        galleryImages: [
          'https://images.unsplash.com/photo-1511192336575-5a79af67a629',
          'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f',
          'https://images.unsplash.com/photo-1506157786151-b8491531f063',
        ],
        organizerContact: '+251911234567',
        website: 'https://www.ethiopianjazznight.com',
        location: 'Addis Ababa',
        isBookmarked: false,
      ),
      Event(
        id: '2',
        name: 'Traditional Coffee Ceremony',
        description:
            'Learn about and experience the traditional Ethiopian coffee ceremony.',
        venue: 'Tomoca Coffee',
        date: DateTime.now().add(const Duration(days: 1)),
        category: 'Culture',
        entryFee: 200.0,
        capacity: 30,
        imageUrl:
            'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
        galleryImages: [
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
          'https://images.unsplash.com/photo-1506619216599-9d16d0903dfd',
          'https://images.unsplash.com/photo-1481833761820-0509d3217039',
        ],
        organizerContact: '+251922345678',
        website: 'https://www.tomocacoffee.com',
        location: 'Addis Ababa',
        isBookmarked: false,
      ),
      Event(
        id: '3',
        name: 'Art Exhibition: Modern Ethiopia',
        description:
            'Contemporary Ethiopian artists showcase their latest works.',
        venue: 'National Museum',
        date: DateTime.now().add(const Duration(days: 3)),
        category: 'Art',
        entryFee: 100.0,
        capacity: 150,
        imageUrl:
            'https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07',
        galleryImages: [
          'https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07',
          'https://images.unsplash.com/photo-1513364776144-60967b0f800f',
          'https://images.unsplash.com/photo-1499781350541-7783f6c6a0c8',
        ],
        organizerContact: '+251933456789',
        website: 'https://www.modernethiopia.art',
        location: 'Addis Ababa',
        isBookmarked: false,
      ),
    ];
  }

  Future<List<Event>> getEvents({
    String? category,
    String? searchQuery,
    String? timeFilter,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final queryParams = <String, String>{};
      if (category != null) queryParams['category'] = category;
      if (searchQuery != null) queryParams['search'] = searchQuery;
      if (timeFilter != null) queryParams['time'] = timeFilter;

      final uri =
          Uri.parse('$baseUrl/events').replace(queryParameters: queryParams);
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        // Return mock data if API fails
        List<Event> mockEvents = _getMockEvents();

        // Apply filters to mock data
        if (category != null && category != 'All') {
          mockEvents =
              mockEvents.where((event) => event.category == category).toList();
        }
        if (searchQuery != null && searchQuery.isNotEmpty) {
          mockEvents = mockEvents
              .where((event) =>
                  event.name
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  event.description
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
              .toList();
        }
        if (timeFilter != null) {
          final now = DateTime.now();
          switch (timeFilter) {
            case 'today':
              mockEvents = mockEvents
                  .where((event) =>
                      event.date.year == now.year &&
                      event.date.month == now.month &&
                      event.date.day == now.day)
                  .toList();
              break;
            case 'this_week':
              final weekStart = now.subtract(Duration(days: now.weekday - 1));
              final weekEnd = weekStart.add(const Duration(days: 7));
              mockEvents = mockEvents
                  .where((event) =>
                      event.date.isAfter(weekStart) &&
                      event.date.isBefore(weekEnd))
                  .toList();
              break;
            case 'this_month':
              mockEvents = mockEvents
                  .where((event) =>
                      event.date.year == now.year &&
                      event.date.month == now.month)
                  .toList();
              break;
          }
        }
        return mockEvents;
      }
    } catch (e) {
      return _getMockEvents();
    }
  }

  Future<Event> getEventById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final response = await _client.get(Uri.parse('$baseUrl/events/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Event.fromJson(data);
      } else {
        // Return mock event if API fails
        final mockEvent = _getMockEvents().firstWhere(
          (event) => event.id == id,
          orElse: () => throw Exception('Event not found'),
        );
        return mockEvent;
      }
    } catch (e) {
      // Return mock event if API fails
      final mockEvent = _getMockEvents().firstWhere(
        (event) => event.id == id,
        orElse: () => throw Exception('Event not found'),
      );
      return mockEvent;
    }
  }

  // Future<void> toggleBookmark(String eventId, BuildContext context) async {
  //   await Future.delayed(const Duration(milliseconds: 500));

  //   try {
  //     final response = await _client.post(
  //       Uri.parse('$baseUrl/events/$eventId/bookmark'),
  //       headers: _getHeaders(context),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to toggle bookmark');
  //     }
  //   } catch (e) {
  //     // Silently fail for mock data
  //   }
  // }

  // Future<List<Event>> getBookmarkedEvents(BuildContext context) async {
  //   await Future.delayed(const Duration(seconds: 1));

  //   try {
  //     final response = await _client.get(
  //       Uri.parse('$baseUrl/events/bookmarked'),
  //       headers: _getHeaders(context),
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       return data.map((json) => Event.fromJson(json)).toList();
  //     } else {
  //       // Return empty list for mock data
  //       return [];
  //     }
  //   } catch (e) {
  //     // Return empty list for mock data
  //     return [];
  //   }
  // }

  // Map<String, String> _getHeaders(BuildContext context) {
  //   // final token = context.read<AuthProvider>().token;
  //   return {
  //     'Content-Type': 'application/json',
  //     if (token != null) 'Authorization': 'Bearer $token',
  //   };
  // }



}
