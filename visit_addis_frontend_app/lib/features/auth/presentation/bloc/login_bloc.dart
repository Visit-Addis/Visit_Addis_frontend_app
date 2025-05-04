import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/auth_service.dart';

// Events for Login
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);
}

// States for Login
class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? error;

  LoginState({this.isLoading = false, this.isLoggedIn = false, this.error});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc(this.authService) : super(LoginState()) {
    on<LoginUserEvent>((event, emit) async {
      emit(LoginState(isLoading: true)); // Start loading
      try {
        await authService.login(event.email, event.password);
        emit(LoginState(isLoggedIn: true)); // Emit success state
      } catch (e) {
        emit(LoginState(error: e.toString())); // Emit error state
      }
    });
  }
}