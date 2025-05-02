import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 1)); // Simulate API call
        _errorMessage = null;
        return true;
      } else {
        throw Exception('Email and password cannot be empty');
      }
    } catch (e) {
      _errorMessage = 'Invalid credentials. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
