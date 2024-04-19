import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var requestBody = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        Uri.parse('http://54.161.17.51:8000/api/auth/login/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        return null; // No error message
      } else {
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['error'] ?? 'Login failed';
        return errorMessage;
      }
    } catch (e) {
      return 'Error logging in: ${e.toString()}';
    }
  }
}
