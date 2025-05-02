import '../data_sources/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

  Future<void> login(String email, String password) async {
    await remoteDataSource.login(email, password);
  }

  Future<void> register(String name, String email, String password) async {
    await remoteDataSource.register(name, email, password);
  }

  Future<void> loginWithGoogle() async {
    await remoteDataSource.loginWithGoogle();
  }
}
