
import 'package:suwaida_bread/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    try {
      final token = await _authService.login(email, password);
      // In a real app, you would use a secure storage solution
      // like flutter_secure_storage to store the token.
      // For this example, we'll just print it to the console.
      print('Logged in with token: $token');
    } catch (e) {
      rethrow;
    }
  }
}
