import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<String?> registerUser({
    required String email,
    required String password,
    required String password2,
    required String username,
    required String first_name,
    required String last_name,
    required String userType,
  }) async {
    try {
      var requestBody = {
        'email': email,
        'password': password,
        'password2': password2,
        'username': username,
        'first_name': first_name,
        'last_name': last_name,
        'user_type': userType,
      };

      var response = await http.post(
        Uri.parse('http://54.161.17.51:8000/api/auth/register/'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        body: requestBody,
      );

      print('Register User Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else if (response.statusCode == 400) {
        var responseData = jsonDecode(response.body);
        var errorMessage = '';
        if (responseData.containsKey('username')) {
          errorMessage = 'A user with that username already exists.';
        } else if (responseData.containsKey('email')) {
          errorMessage = 'Email field -> ${responseData['email'][0]}';
        } else if (responseData.containsKey('password')) {
          errorMessage = 'Password field -> ${responseData['password'][0]}';
        } else if (responseData.containsKey('user_type')) {
          errorMessage = 'User type field -> ${responseData['user_type'][0]}';
        } else {
          errorMessage = 'Registration failed';
        }
        return errorMessage;
      } else {
        return 'Registration failed';
      }
    } catch (e) {
      print('Error registering user: $e');
      return 'Error registering user: ${e.toString()}';
    }
  }
}
