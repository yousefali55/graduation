import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/profile_view/change%20password/data/change_password_states.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    emit(ChangePasswordLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      emit(const ChangePasswordFailure('Token not found'));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://54.161.17.51:8000/api/change-password/'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        },
        body: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        emit(ChangePasswordSuccess());
      } else {
        final responseBody = json.decode(response.body);
        emit(ChangePasswordFailure(
            responseBody['message'] ?? 'Failed to change password!'));
      }
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }
}
