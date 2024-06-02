import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_states.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicCubit extends Cubit<EditProfileState> {
  ProfilePicCubit() : super(EditProfileInitial());

  Future<void> updateProfilePic(File profilePic) async {
    emit(EditProfileLoading());
    var url = Uri.parse('http://54.161.17.51:8000/api/profile/update/');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        emit(EditProfileFailure('Token not found'));
        return;
      }

      var request = http.MultipartRequest('PUT', url)
        ..headers['Authorization'] = 'Token $token'
        ..files
            .add(await http.MultipartFile.fromPath('avatar', profilePic.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        print('Response status: ${response.statusCode}');
        print('Response body: ${responseBody.body}');

        emit(EditProfileSuccess());
      } else {
        emit(EditProfileFailure(
            'Failed to update profile pic. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(EditProfileFailure(e.toString()));
    }
  }
}
