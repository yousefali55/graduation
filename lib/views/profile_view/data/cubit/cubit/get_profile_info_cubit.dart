import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/profile_view/data/profile_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_profile_info_state.dart';

class GetProfileInfoCubit extends Cubit<GetProfileInfoState> {
  GetProfileInfoCubit() : super(GetProfileInfoInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/profile/";

  Future<void> fetchProfileInfo() async {
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

      if (response.statusCode == 200) {
        final data = response.data;
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