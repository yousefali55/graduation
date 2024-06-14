import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetOwnerApartmentsCubit extends Cubit<GetOwnerApartmentsState> {
  GetOwnerApartmentsCubit() : super(GetOwnerApartmentsInitial());

  final String apiUrl =
      "http://54.161.17.51:8000/api/apartments/owner-apartments/";
  Dio dio = Dio();

  Future<void> fetchApartments() async {
    emit(GetOwnerApartmentsLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      emit(GetOwnerApartmentsFailure(errorMessage: 'Token not found'));
      return;
    }

    try {
      Response response = await dio.get(
        apiUrl,
        options: Options(headers: {'Authorization': 'Token $token'}),
      );

      print('Response data: ${response.data}'); // Debug log

      if (response.statusCode == 200) {
        final responseData = response.data['results'] as List;

        List<ApartmentModel> apartments =
            responseData.map((json) => ApartmentModel.fromJson(json)).toList();

        print('Parsed apartments: $apartments'); // Debug log

        emit(GetOwnerApartmentsSuccess(apartments: apartments));
      } else {
        emit(GetOwnerApartmentsFailure(
            errorMessage: 'Failed to load apartments: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetOwnerApartmentsFailure(
          errorMessage: 'Failed to load apartments: $e'));
    }
  }
}
