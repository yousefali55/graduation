import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetApartmentsCubit extends Cubit<GetApartmentsState> {
  GetApartmentsCubit() : super(GetApartmentsInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/apartments/";
  late List<ApartmentModel> apartments = [];
  List<ApartmentModel> favorites = [];

  Future<void> fetchApartments() async {
    final Dio dio = Dio();

    try {
      emit(GetApartmentsLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        emit(GetApartmentsFailure(errorMessage: 'Token not found'));
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
        final List<dynamic> responseData = response.data['results'];
        apartments =
            responseData.map((json) => ApartmentModel.fromJson(json)).toList();
        emit(
            GetApartmentsSuccess(apartments: apartments, favorites: favorites));
      } else {
        emit(GetApartmentsFailure(
            errorMessage: 'Failed to load apartments: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetApartmentsFailure(errorMessage: 'Failed to load apartments: $e'));
    }
  }

  Future<void> addToFavorites(ApartmentModel apartment) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      emit(GetApartmentsFailure(errorMessage: 'Token not found'));
      return;
    }

    try {
      print('Attempting to add to favorites');
      print('Apartment ID: ${apartment.id}');
      print('Token: $token');

      emit(GetApartmentsLoading());
      final response = await dio.post(
        'http://54.161.17.51:8000/api/apartments/${apartment.id}/save/',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        favorites.add(apartment);
        apartment.isFavorite = true;
        emit(
            GetApartmentsSuccess(apartments: apartments, favorites: favorites));
      } else {
        print('Response status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        emit(GetApartmentsFailure(
            errorMessage:
                'Failed to add to favorites: ${response.statusCode}'));
      }
    } catch (e) {
      print('Exception: $e');
      emit(
          GetApartmentsFailure(errorMessage: 'Failed to add to favorites: $e'));
    }
  }

  Future<void> removeFromFavorites(ApartmentModel apartment) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      emit(GetApartmentsFailure(errorMessage: 'Token not found'));
      return;
    }

    try {
      print('Attempting to remove from favorites');
      print('Apartment ID: ${apartment.id}');
      print('Token: $token');

      emit(GetApartmentsLoading());
      final response = await dio.delete(
        'http://54.161.17.51:8000/api/saved_apartments/${apartment.id}/remove/',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        favorites.remove(apartment);
        apartment.isFavorite = false;
        emit(
            GetApartmentsSuccess(apartments: apartments, favorites: favorites));
      } else {
        print('Response status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        emit(GetApartmentsFailure(
            errorMessage:
                'Failed to remove from favorites: ${response.statusCode}'));
      }
    } catch (e) {
      print('Exception: $e');
      emit(GetApartmentsFailure(
          errorMessage: 'Failed to remove from favorites: $e'));
    }
  }
}
