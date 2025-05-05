import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/events_model.dart';
import '../../data/services/event_service.dart';

class EventState {
  final List<Event> events;
  final bool loading;
  final String? error;

  EventState({
    this.events = const [],
    this.loading = false,
    this.error,
  });
}

class EventCubit extends Cubit<EventState> {
  final EventsApiService apiService;

  EventCubit(this.apiService) : super(EventState());

  Future<void> fetchEvents() async {
    emit(EventState(loading: true)); // Emit loading state
    try {
      final events = await apiService.fetchEvents();
      emit(EventState(events: events)); // Emit loaded state with events
    } catch (e) {
      emit(EventState(error: e.toString())); // Emit error state
    }
  }
}
