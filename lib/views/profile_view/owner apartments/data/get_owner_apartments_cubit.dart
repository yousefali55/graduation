import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_owner_apartments_states.dart';

class GetOwnerApartmentsCubit extends Cubit<GetOwnerApartmentsState> {
  GetOwnerApartmentsCubit() : super(GetOwnerApartmentsInitial());
  final String apiUrl =
      "http://54.161.17.51:8000/api/apartments/owner-apartments/";
  Dio dio = Dio();

  Future<void> fetchOwnerApartments() async {
    emit(GetOwnerApartmentsLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      Response response = await dio.get(apiUrl,
          options: Options(headers: {'Authorization': 'Token $token'}));
      if (response.statusCode == 200) {
        final apartments = (response.data['results'] as List)
            .map((apartmentJson) => ApartmentModel.fromJson(apartmentJson))
            .toList();
        emit(GetOwnerApartmentsSuccess(apartments));
      } else {
        emit(GetOwnerApartmentsFailure(
            errorMessage: 'Error fetching apartments'));
      }
    } catch (e) {
      emit(GetOwnerApartmentsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteApartment(int apartmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      Response response = await dio.delete(
        'http://54.161.17.51:8000/api/apartments/$apartmentId/delete/',
        options: Options(headers: {'Authorization': 'Token $token'}),
      );

      if (response.statusCode == 204) {
        emit(ApartmentDeleted());
        fetchOwnerApartments();
      } else {
        emit(GetOwnerApartmentsFailure(
            errorMessage: 'Error deleting apartment: ${response.data}'));
      }
    } catch (e) {
      emit(GetOwnerApartmentsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateApartment(ApartmentModel updatedApartment) async {
    emit(GetOwnerApartmentsLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      Response response = await dio.put(
        'http://54.161.17.51:8000/api/apartments/${updatedApartment.id}/update/',
        data: updatedApartment.toJson(),
        options: Options(headers: {'Authorization': 'Token $token'}),
      );

      if (response.statusCode == 200) {
        emit(ApartmentUpdated());
        fetchOwnerApartments();
      } else {
        emit(GetOwnerApartmentsFailure(
            errorMessage: 'Error updating apartment: ${response.data}'));
      }
    } catch (e) {
      emit(GetOwnerApartmentsFailure(errorMessage: e.toString()));
    }
  }
}
