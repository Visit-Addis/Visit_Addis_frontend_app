// import 'package:flutter/foundation.dart';
// import '../../data/services/auth_service.dart';

// class AuthProvider with ChangeNotifier {
//   final AuthService _authService;
//   String? _token;
//   bool _isLoading = false;
//   String? _error;

//   AuthProvider({AuthService? authService})
//       : _authService = authService ?? AuthService();

//   String? get token => _token;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   bool get isAuthenticated => _token != null;

//   Future<void> initialize() async {
//     await loadToken();
//   }

//   Future<void> loadToken() async {
//     // _token = await _authService.getStoredToken();
//     notifyListeners();
//   }

//   Future<void> persistToken() async {
//     if (_token != null) {
//       // await _authService.storeToken(_token!);
//     }
//   }

//   Future<void> login(String email, String password) async {
//     if (validateEmail(email) != null || validatePassword(password) != null) {
//       throw 'Invalid input';
//     }

//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _token = await _authService.login(email, password);
//       await persistToken();
//       _error = null;
//     } catch (e) {
//       _error = _translateAuthError(e.toString());
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> register(String email, String password, String name) async {
//     if (validateEmail(email) != null || validatePassword(password) != null) {
//       throw 'Invalid input';
//     }

//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _token = await _authService.register(email, password, name);
//       await persistToken();
//       _error = null;
//     } catch (e) {
//       _error = _translateAuthError(e.toString());
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> logout() async {
//     _token = null;
//     _error = null;
//     // await _authService.clearToken();
//     notifyListeners();
//   }

//   String _translateAuthError(String error) {
//     if (error.contains('invalid-credentials')) {
//       return 'Invalid email or password';
//     } else if (error.contains('email-already-exists')) {
//       return 'Email already in use';
//     } else if (error.contains('weak-password')) {
//       return 'Password too weak (min 6 chars)';
//     } else if (error.contains('network-error')) {
//       return 'Network connection failed';
//     }
//     return 'Authentication failed. Please try again.';
//   }

//   String? validateEmail(String? email) {
//     if (email == null || email.isEmpty) return 'Email is required';
//     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
//       return 'Enter a valid email';
//     }
//     return null;
//   }

//   String? validatePassword(String? password) {
//     if (password == null || password.isEmpty) return 'Password is required';
//     if (password.length < 6) return 'Password too short (min 6 chars)';
//     return null;
//   }
// }
