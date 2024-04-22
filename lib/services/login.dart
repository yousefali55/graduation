import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<String?> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      var requestBody = {
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('http://54.161.17.51:8000/api/auth/login/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var token = responseData['token'] ?? '';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        // return token;
      } else {
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['error'] ??
            'Unable to log in with provided credentials';
        return errorMessage;
      }
    } catch (e) {
      print('Error logging in: $e');
      return 'Error logging in: ${e.toString()}';
    }
  }
}
