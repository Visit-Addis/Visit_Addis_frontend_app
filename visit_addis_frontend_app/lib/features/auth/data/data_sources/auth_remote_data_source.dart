abstract class AuthRemoteDataSource {
  Future<void> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> loginWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }
    if (password != 'password123') {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('All fields are required');
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    // Simulate Google Sign-In
    await Future.delayed(const Duration(seconds: 1));
    // Simulate a successful Google login
    print('Google login successful');
  }
}
