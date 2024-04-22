import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart'; // Import Dio
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
part 'get_apartments_state.dart';

class GetApartmentsCubit extends Cubit<GetApartmentsState> {
  GetApartmentsCubit() : super(GetApartmentsInitial());
  final String apiUrl = "http://54.161.17.51:8000/api/apartments/";
  List<ApartmentModel> apartments = [];
  Future<void> fetchApartments() async {
    final Dio dio = Dio();

    try {
      emit(GetApartmentsLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        emit(GetApartmentsFailure(errorMessage: 'Token not found'));
      }
      Response response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Token $token',
          },
        ),
      );
      if(response.statusCode == 200){

      final List<dynamic> responseData = response.data['results'];
      print(responseData);
      apartments =
          responseData.map((json) => ApartmentModel.fromJson(json)).toList();
      print('===================$token');
      emit(GetApartmentsSuccess());
      }
      else{
        emit(GetApartmentsFailure(errorMessage: '${response.statusCode}'));
      }
    } catch (e) {
      emit(GetApartmentsFailure(errorMessage: e.toString()));
    }
  }
}
