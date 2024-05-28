import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class ImageVerificationService {
  final String apiUrl = "https://detect.roboflow.com";
  final String apiKey = "KF1fPDvKE6FSJ98Tpjhw";

  Future<bool> verifyImage(File image) async {
    final bytes = image.readAsBytesSync();
    final base64Image = base64Encode(bytes);

    final Dio dio = Dio();
    final response = await dio.post(
      apiUrl,
      data: {
        'api_key': apiKey,
        'image': base64Image,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return data['predictions']
          .isNotEmpty; // Assuming the API response contains predictions
    } else {
      throw Exception('Failed to verify image');
    }
  }
}
