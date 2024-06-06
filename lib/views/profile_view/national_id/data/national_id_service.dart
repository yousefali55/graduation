import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class NationalIdService {
  final String apiUrl = "http://54.161.17.51:8000/api/submit-national-id/";

  Future<void> submitNationalId({
    required String birthDate,
    required String birthGovernorate,
    required String gender,
    required String nationalId,
    required File image,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers['Authorization'] = 'Token $token';
      request.headers['Accept'] = 'application/json';
      request.fields['birth_date'] = birthDate;
      request.fields['birth_governorate'] = birthGovernorate;
      request.fields['gender'] = gender;
      request.fields['national_id'] = nationalId;
      request.files.add(await http.MultipartFile.fromPath(
        'national_id_image',
        image.path,
        filename: basename(image.path),
      ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Success: $responseBody');
      } else {
        print('Error: ${response.statusCode} $responseBody');
        if (response.statusCode == 401) {
          throw Exception('Unauthorized: Please check your login credentials.');
        } else {
          throw Exception('Failed to submit national ID');
        }
      }
    } catch (e) {
      print('Error during national ID submission: $e');
      throw Exception('Failed to submit national ID');
    }
  }
}
