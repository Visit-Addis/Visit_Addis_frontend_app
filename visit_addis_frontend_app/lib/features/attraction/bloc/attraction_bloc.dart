import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/attraction_models.dart';
import '../data/services/api_service.dart';

class AttractionState {
  final List<Attraction> attractions;
  final bool loading;
  final String? error;

  AttractionState(
      {this.attractions = const [], this.loading = false, this.error});
}

class AttractionCubit extends Cubit<AttractionState> {
  final ApiService apiService;

  AttractionCubit(this.apiService) : super(AttractionState());

  Future<void> fetchAttractions() async {
    emit(AttractionState(loading: true));
    try {
      final attractions = await apiService.fetchAttractions();
      emit(AttractionState(attractions: attractions));
    } catch (e) {
      emit(AttractionState(error: e.toString()));
    }
  }
}
