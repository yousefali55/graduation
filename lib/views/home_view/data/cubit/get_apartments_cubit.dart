import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetApartmentsCubit extends Cubit<GetApartmentsState> {
  GetApartmentsCubit() : super(GetApartmentsInitial());

  final String apiUrl = "http://54.161.17.51:8000/api/apartments/";
  late List<ApartmentModel> apartments = []; // Initialize apartments list
  List<ApartmentModel> favorites = []; // Initialize favorites list

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
        apartments = responseData
            .map((json) => ApartmentModel.fromJson(json))
            .toList(); // Assign fetched apartments to the list
        emit(
            GetApartmentsSuccess(apartments: apartments, favorites: favorites));
      } else {
        emit(GetApartmentsFailure(errorMessage: '${response.statusCode}'));
      }
    } catch (e) {
      emit(GetApartmentsFailure(errorMessage: e.toString()));
    }
  }

  void addToFavorites(ApartmentModel apartment) {
    favorites.add(apartment);
    apartment.isFavorite = true; // Update isFavorite property
    emit(GetApartmentsSuccess(apartments: apartments, favorites: favorites));
  }

  void removeFromFavorites(ApartmentModel apartment) {
    favorites.remove(apartment);
    apartment.isFavorite = false; // Update isFavorite property
    emit(GetApartmentsSuccess(apartments: apartments, favorites: favorites));
  }
}
