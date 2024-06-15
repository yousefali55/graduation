import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/profile_view/owner%20apartments/delete%20apartments/delete_apartment_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteOwnerApartmentCubit extends Cubit<DeleteOwnerApartmentState> {
  DeleteOwnerApartmentCubit() : super(DeleteOwnerApartmentInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/apartments";
  final Dio dio = Dio();

  Future<void> deleteApartment(int apartmentId) async {
    emit(DeleteOwnerApartmentLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('Token not found');
        emit(DeleteOwnerApartmentFailure(errorMessage: 'Token not found'));
        return;
      }

      dio.options.headers['Authorization'] = 'Token $token';

      print('Sending DELETE request to $apiUrl/$apartmentId/delete/');

      final response = await dio.delete('$apiUrl/$apartmentId/delete/');

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        emit(DeleteOwnerApartmentSuccess());
      } else {
        final errorResponse = response.data;
        final errorMessage =
            errorResponse['message'] ?? 'Unknown error occurred';
        emit(DeleteOwnerApartmentFailure(
            errorMessage: 'Failed to delete apartment: $errorMessage'));
      }
    } catch (e) {
      if (e is DioException) {
        final dioError = e;
        final response = dioError.response;
        if (response != null) {
          print('Error Response status code: ${response.statusCode}');
          print('Error Response data: ${response.data}');
          emit(DeleteOwnerApartmentFailure(
              errorMessage: 'Failed to delete apartment: ${response.data}'));
        } else {
          print('DioError message: ${dioError.message}');
          emit(DeleteOwnerApartmentFailure(
              errorMessage: 'Failed to delete apartment: ${dioError.message}'));
        }
      } else {
        print('Exception: $e');
        emit(DeleteOwnerApartmentFailure(
            errorMessage: 'Failed to delete apartment: $e'));
      }
    }
  }
}
