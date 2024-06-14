import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_states.dart';

class EditOwnerApartmentCubit extends Cubit<EditOwnerApartmentState> {
  EditOwnerApartmentCubit() : super(EditOwnerApartmentInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/apartments";

  Dio dio = Dio();

  Future<void> updateApartment(ApartmentModel apartment) async {
    emit(EditOwnerApartmentLoading());

    try {
      final response = await dio.put(
        '$apiUrl/${apartment.id}/update/',
        data: apartment.toJson(),
      );

      if (response.statusCode == 200) {
        emit(EditOwnerApartmentSuccess(apartment: apartment));
      } else {
        emit(EditOwnerApartmentFailure(
            errorMessage:
                'Failed to update apartment: ${response.statusCode}'));
      }
    } catch (e) {
      emit(EditOwnerApartmentFailure(
          errorMessage: 'Failed to update apartment: $e'));
    }
  }
}
