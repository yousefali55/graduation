import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation/views/profile_view/data/profile_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_profile_info_state.dart';

class GetProfileInfoCubit extends Cubit<GetProfileInfoState> {
  GetProfileInfoCubit() : super(GetProfileInfoInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/profile/";
  bool _isClosed = false; // Add a flag to track the closed state

  @override
  Future<void> close() {
    _isClosed = true; // Set the flag to true when closing
    return super.close();
  }

  Future<void> fetchProfileInfo() async {
    if (_isClosed) {
      return; // Avoid fetching data if the Bloc is already closed
    }

    final Dio dio = Dio();
    emit(GetProfileInfoLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        emit(GetProfileInfoFailure(errorMessage: 'Token not found'));
        return;
      }

      Response response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (_isClosed) {
        return; // Check again after async operation before emitting
      }

      if (response.statusCode == 200) {
        final data = response.data;
        data['saved_apartments'] ??= []; // Default to empty list if null
        final profile = ProfileModel.fromJson(data);
        emit(GetProfileInfoSuccess(profileModel: profile));
      } else {
        emit(GetProfileInfoFailure(
            errorMessage: 'Failed to fetch profile info'));
      }
    } catch (e) {
      emit(GetProfileInfoFailure(errorMessage: e.toString()));
    }
  }
}
