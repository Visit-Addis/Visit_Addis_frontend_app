import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user.dart';
import '../../data/services/auth_service.dart';

abstract class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final User user;

  RegisterUserEvent(this.user);
}

class RegistrationState {
  final bool isLoading;
  final bool isRegistered;
  final String? error;

  RegistrationState(
      {this.isLoading = false, this.isRegistered = false, this.error});
}

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthService authService;

  RegistrationBloc(this.authService) : super(RegistrationState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegistrationState(isLoading: true)); // Start loading

      try {
        final isSuccess = await authService.register(event.user);
        if (isSuccess) {
          emit(RegistrationState(isRegistered: true)); // Success
        } else {
          emit(RegistrationState(error: 'Registration failed')); // Failure
        }
      } catch (e) {
        emit(RegistrationState(error: e.toString())); // Handle errors
      }
    });
  }
}
