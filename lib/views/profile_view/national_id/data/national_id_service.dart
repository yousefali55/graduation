import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    FormData formData = FormData.fromMap({
      'birth_date': birthDate,
      'birth_governorate': birthGovernorate,
      'gender': gender,
      'national_id': nationalId,
      'national_id_image': await MultipartFile.fromFile(image.path,
          filename: "compressed_image.jpg"),
    });

    final Dio dio = Dio();

    Response response = await dio.post(
      apiUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit national ID');
    }
  }
}
