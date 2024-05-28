import 'package:bloc/bloc.dart';
import 'package:graduation/views/profile_view/delete_account/data/delete_account_states.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    var url = Uri.parse('http://54.161.17.51:8000/api/deactivate-account/');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('Token not found');
        emit(DeleteAccountFailure('Token not found'));
        return;
      }

      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        emit(DeleteAccountSuccess());
      } else {
        emit(DeleteAccountFailure(
            'Failed to delete account. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      print('Exception details:\n $e');
      emit(DeleteAccountFailure(e.toString()));
    }
  }
}
