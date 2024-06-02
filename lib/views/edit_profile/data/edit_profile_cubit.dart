import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_states.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> updateProfile(String firstName, String lastName, String email,
      String phoneNumber, String address, String username) async {
    emit(EditProfileLoading());
    var url = Uri.parse('http://54.161.17.51:8000/api/profile/update/');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('Token not found');
        emit(EditProfileFailure('Token not found'));
        return;
      }

      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Token $token',
        },
        body: <String, String>{
          'username': username,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
          'address': address,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        emit(EditProfileSuccess());
      } else {
        emit(EditProfileFailure(
            'Failed to update profile. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      print('Exception details:\n $e');
      emit(EditProfileFailure(e.toString()));
    }
  }
}
