
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _loginUrl = 'https://site66674-c6ivs9.scloudsite101.com/app/login_api.php';

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['sessionToken'] != null) {
        return data['sessionToken'];
      } else {
        throw Exception(data['message'] ?? 'Failed to log in');
      }
    } else {
      throw Exception('Failed to log in with status code: ${response.statusCode}');
    }
  }
}
