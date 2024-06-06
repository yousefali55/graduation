import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageVerificationService {
  final String apiUrl = "https://detect.roboflow.com/national-id-wxwph/2";
  final String apiKey = "KF1fPDvKE6FSJ98Tpjhw";

  Future<bool> verifyImage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $apiKey',
        },
        body: {
          'image': base64Image,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Image verification response: $data');
        return data['predictions'].isNotEmpty;
      } else {
        print('Error response: ${response.statusCode} ${response.body}');
        throw Exception('Failed to verify image: ${response.body}');
      }
    } catch (e) {
      print('Exception during image verification: $e');
      throw Exception('Failed to verify image: $e');
    }
  }
}
