import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/hotels_model.dart'; // Adjust the import based on your project structure
import '../../data/services/hotel_service.dart'; // Adjust the import based on your project structure

class HotelState {
  final List<Restaurant> hotels;
  final bool loading;
  final String? error;

  HotelState({
    this.hotels = const [],
    this.loading = false,
    this.error,
  });
}

class HotelCubit extends Cubit<HotelState> {
  final HotelsApiService apiService;

  HotelCubit(this.apiService) : super(HotelState());

  Future<void> fetchHotels() async {
    emit(HotelState(loading: true)); // Emit loading state
    try {
      final hotels = await apiService.fetchHotels();
      emit(HotelState(hotels: hotels)); // Emit loaded state with hotels
    } catch (e) {
      emit(HotelState(error: e.toString())); // Emit error state
    }
  }
}