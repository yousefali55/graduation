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
  Dio dio = Dio();

  Future<void> fetchApartments() async {
    emit(GetApartmentsLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      emit(GetApartmentsFailure(errorMessage: 'Token not found'));
      return;
    }
    try {
      Response response = await dio.get(apiUrl,
          options: Options(headers: {'Authorization': 'Token $token'}));
      if (response.statusCode == 200) {
        final responseData = response.data['results'] as List;
        apartments =
            responseData.map((json) => ApartmentModel.fromJson(json)).toList();
        await fetchFavorites(token);
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

  Future<void> fetchFavorites(String token) async {
    try {
      Response response = await dio.get('http://54.161.17.51:8000/api/profile/',
          options: Options(headers: {'Authorization': 'Token $token'}));
      if (response.statusCode == 200) {
        final responseData = response.data['saved_apartments'] as List;
        favorites =
            responseData.map((json) => ApartmentModel.fromJson(json)).toList();
        for (var favorite in favorites) {
          for (var apartment in apartments) {
            if (apartment.id == favorite.id) {
              apartment.isFavorite = true;
              break;
            }
          }
        }
      }
    } catch (e) {
      print('Failed to fetch favorites: $e');
    }
  }

  Future<void> toggleFavorite(ApartmentModel apartment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      emit(GetApartmentsFailure(errorMessage: 'Token not found'));
      return;
    }
    try {
      if (apartment.isFavorite) {
        await removeFromFavorites(apartment);
      } else {
        await addToFavorites(apartment, token);
      }
    } catch (e) {
      emit(GetApartmentsFailure(errorMessage: 'Failed to toggle favorite: $e'));
    }
  }

  Future<void> addToFavorites(ApartmentModel apartment, String token) async {
    try {
      Response response = await dio.post(
          'http://54.161.17.51:8000/api/apartments/${apartment.id}/save/',
          options: Options(headers: {'Authorization': 'Token $token'}));

      if (response.statusCode == 201 || response.statusCode == 200) {
        favorites.add(apartment);
        apartment.isFavorite = true;
        emit(
            GetApartmentsSuccess(apartments: apartments, favorites: favorites));
        print('this is apartment id :${apartment.id}');
      } else {
        final responseBody = response.data;
        if (response.statusCode == 400 &&
            responseBody['status'] == 'Apartment already saved') {
          apartment.isFavorite = true;
          favorites.add(apartment);
          emit(GetApartmentsSuccess(
              apartments: apartments, favorites: favorites));
        } else {
          // Enhanced error handling for addToFavorites
          print(
              'Error adding to favorites (status code ${response.statusCode}): $responseBody'); // Log detailed error
          emit(GetApartmentsFailure(
              errorMessage:
                  'Failed to add to favorites: $responseBody')); // Emit specific error message
        }
      }
    } catch (e) {
      emit(
          GetApartmentsFailure(errorMessage: 'Failed to add to favorites: $e'));
    }
  }

  Future<void> removeFromFavorites(ApartmentModel apartment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      emit(GetApartmentsFailure(errorMessage: 'Token not found'));
      return;
    }

    try {
      Response response = await dio.delete(
        'http://54.161.17.51:8000/api/saved_apartments/${apartment.id}/remove/',
        options: Options(headers: {'Authorization': 'Token $token'}),
      );

      if (response.statusCode == 204) {
        favorites
            .removeWhere((favApartment) => favApartment.id == apartment.id);
        apartment.isFavorite = false;
        emit(GetApartmentsSuccess(
          apartments: apartments,
          favorites: favorites,
        ));
      } else if (response.statusCode == 404) {
        // Apartment not found in favorites (already removed)
        favorites
            .removeWhere((favApartment) => favApartment.id == apartment.id);
        emit(GetApartmentsSuccess(
          apartments: apartments,
          favorites: favorites,
        ));
      } else {
        // Handle other status codes
        emit(GetApartmentsFailure(
          errorMessage:
              'Failed to remove from favorites: ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(GetApartmentsFailure(
        errorMessage: 'Failed to remove from favorites: $e',
      ));
    }
  }
}
