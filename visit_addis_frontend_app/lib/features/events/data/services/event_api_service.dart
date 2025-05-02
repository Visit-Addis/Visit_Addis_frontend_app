import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/event.dart';

class EventApiService {
  // Mock data since we don't have a backend yet
  Future<List<Event>> getEvents() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data
    return [
      Event(
        id: '1',
        name: 'Ethiopian Jazz Night',
        description: 'Experience the best of Ethiopian jazz with renowned artists.',
        venue: 'Fendika Cultural Center',
        date: DateTime.now().add(const Duration(days: 2)),
        category: 'Music',
        entryFee: 500.0,
        capacity: 200,
        imageUrl: 'https://example.com/jazz.jpg',
        galleryImages: [
          'https://example.com/jazz1.jpg',
          'https://example.com/jazz2.jpg',
        ],
        location: 'Kazanchis, Addis Ababa',
        organizerContact: '+251911234567',
        website: 'https://example.com',
        isBookmarked: false,
      ),
      Event(
        id: '2',
        name: 'Traditional Coffee Ceremony',
        description: 'Learn about Ethiopian coffee culture and traditions.',
        venue: 'Tomoca Coffee',
        date: DateTime.now().add(const Duration(days: 3)),
        category: 'Culture',
        entryFee: 300.0,
        capacity: 50,
        imageUrl: 'https://example.com/coffee.jpg',
        galleryImages: [
          'https://example.com/coffee1.jpg',
          'https://example.com/coffee2.jpg',
        ],
        location: 'Bole, Addis Ababa',
        organizerContact: '+251912345678',
        website: 'https://example.com',
        isBookmarked: true,
      ),
      Event(
        id: '3',
        name: 'Art Exhibition',
        description: 'Contemporary Ethiopian art showcase.',
        venue: 'Modern Art Museum',
        date: DateTime.now().add(const Duration(days: 5)),
        category: 'Art',
        entryFee: 200.0,
        capacity: 100,
        imageUrl: 'https://example.com/art.jpg',
        galleryImages: [
          'https://example.com/art1.jpg',
          'https://example.com/art2.jpg',
        ],
        location: 'Meskel Square, Addis Ababa',
        organizerContact: '+251913456789',
        website: 'https://example.com',
        isBookmarked: false,
      ),
    ];
  }

  Future<Event> getEventById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return mock event
    return Event(
      id: id,
      name: 'Ethiopian Jazz Night',
      description: 'Experience the best of Ethiopian jazz with renowned artists.',
      venue: 'Fendika Cultural Center',
      date: DateTime.now().add(const Duration(days: 2)),
      category: 'Music',
      entryFee: 500.0,
      capacity: 200,
      imageUrl: 'https://example.com/jazz.jpg',
      galleryImages: [
        'https://example.com/jazz1.jpg',
        'https://example.com/jazz2.jpg',
      ],
      location: 'Kazanchis, Addis Ababa',
      organizerContact: '+251911234567',
      website: 'https://example.com',
      isBookmarked: false,
    );
  }

  Future<void> bookmarkEvent(String id, bool bookmark) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would make an API call to update the bookmark status
  }
} 