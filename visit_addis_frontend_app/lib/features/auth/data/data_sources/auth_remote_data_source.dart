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
  }

  @override
  Future<void> register(String name, String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> loginWithGoogle() async {
    // Simulate Google Sign-In
    await Future.delayed(const Duration(seconds: 1));
  }
}
