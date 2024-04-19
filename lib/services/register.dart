import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<String?> registerUser({
    required String email,
    required String password,
    required String password2,
    required String username,
    required String firstname,
    required String lastname,
    required String userType,
  }) async {
    try {
      var requestBody = jsonEncode({
        'email': email,
        'password': password,
        'password2': password2,
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'user_type': userType,
      });

      var response = await http.post(
        Uri.parse('http://54.161.17.51:8000/api/auth/register/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['error'] ?? 'Registration failed';
        return errorMessage;
      }
    } catch (e) {
      return 'Error registering user: ${e.toString()}';
    }
  }
}
