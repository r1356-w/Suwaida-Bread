
class AuthService {
  // In a real app, this would make a network request to your backend.
  // For this example, we'll simulate a network request.
  Future<String> login(String email, String password) async {
    if (email == 'test@test.com' && password == 'password') {
      // Simulate a successful login and return a dummy JWT.
      return 'dummy_jwt_token';
    } else {
      // Simulate a failed login.
      throw Exception('Failed to log in');
    }
  }
}
