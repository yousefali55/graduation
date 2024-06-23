import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditOwnerApartmentCubit extends Cubit<EditOwnerApartmentState> {
  EditOwnerApartmentCubit() : super(EditOwnerApartmentInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/apartments";
  final Dio dio = Dio();

  Future<void> updateApartment(ApartmentModel apartment) async {
    emit(EditOwnerApartmentLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('Token not found');
        emit(EditOwnerApartmentFailure(errorMessage: 'Token not found'));
        return;
      }

      dio.options.headers['Authorization'] =
          'Token $token'; // Add Authorization header

      print('Sending PUT request to $apiUrl/${apartment.id}/update/');
      print('Request data: ${apartment.toJson()}');

      final response = await dio.put(
        '$apiUrl/${apartment.id}/update/',
        data: apartment.toJson(),
      );

      if (response.statusCode == 200) {
        emit(EditOwnerApartmentSuccess(apartment: apartment));
      } else {
        final errorResponse = response.data;
        final errorMessage =
            errorResponse['message'] ?? 'Unknown error occurred';
        emit(EditOwnerApartmentFailure(
            errorMessage: 'Failed to update apartment: $errorMessage'));
      }
    } catch (e) {
      if (e is DioException) {
        final dioError = e;
        final response = dioError.response;
        if (response != null) {
          print('Error Response status code: ${response.statusCode}');
          print('Error Response data: ${response.data}');
          emit(EditOwnerApartmentFailure(
              errorMessage: 'Failed to update apartment: ${response.data}'));
        } else {
          print('DioError message: ${dioError.message}');
          emit(EditOwnerApartmentFailure(
              errorMessage: 'Failed to update apartment: ${dioError.message}'));
        }
      } else {
        print('Exception: $e');
        emit(EditOwnerApartmentFailure(
            errorMessage: 'Failed to update apartment: $e'));
      }
    }
  }
}
