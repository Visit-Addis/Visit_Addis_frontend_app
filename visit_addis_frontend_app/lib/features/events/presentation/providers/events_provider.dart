import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/services/event_service.dart';
import '../../domain/models/event.dart';

class EventsProvider with ChangeNotifier {
  final EventService _eventService;
  List<Event> _events = [];
  Event? _selectedEvent;
  bool _isLoading = false;
  String? _error;

  EventsProvider({EventService? eventService})
      : _eventService = eventService ?? EventService();

  List<Event> get events => _events;
  Event? get selectedEvent => _selectedEvent;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEvents({
    String? category,
    String? searchQuery,
    String? timeFilter,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _events = await _eventService.getEvents(
        category: category,
        searchQuery: searchQuery,
        timeFilter: timeFilter,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEventById(String id, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedEvent = await _eventService.getEventById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(String eventId, BuildContext context) async {
    try {
      await _eventService.toggleBookmark(eventId, context);
      
      // Update local state
      final index = _events.indexWhere((event) => event.id == eventId);
      if (index != -1) {
        _events[index] = _events[index].copyWith(
          isBookmarked: !_events[index].isBookmarked,
        );
      }
      
      if (_selectedEvent?.id == eventId) {
        _selectedEvent = _selectedEvent!.copyWith(
          isBookmarked: !_selectedEvent!.isBookmarked,
        );
      }
      
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchBookmarkedEvents(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _events = await _eventService.getBookmarkedEvents(context);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectEvent(Event? event) {
    _selectedEvent = event;
    notifyListeners();
  }
} 