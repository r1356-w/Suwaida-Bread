import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suwaida_bread/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final _storage = const FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    try {
      final token = await _authService.login(email, password);
      await _storage.write(key: 'session_token', value: token);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> hasToken() async {
    final token = await _storage.read(key: 'session_token');
    return token != null;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'session_token');
  }
}
