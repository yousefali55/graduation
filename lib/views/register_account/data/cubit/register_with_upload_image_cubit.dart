import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
part 'register_with_upload_image_state.dart';

class RegisterWithUploadImageCubit extends Cubit<RegisterWithUploadImageState> {
  RegisterWithUploadImageCubit() : super(RegisterWithUploadImageInitial());
  String? url;
  File? file;
  TextEditingController userNameController = TextEditingController();

  uploadImage() async {
    try {
      emit(UploadImageLoading());
      final ImagePicker imagePicker = ImagePicker();
      final XFile? imagegallery =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (imagegallery != null) {
        file = File(imagegallery.path);
        var imageName = basename(imagegallery.path);
        var request = http.MultipartRequest(
            'POST', Uri.parse('https://your-api-url/upload'));
        request.files.add(http.MultipartFile(
            'file', file!.readAsBytes().asStream(), file!.lengthSync(),
            filename: imageName));
        var response = await request.send();
        var responseData = await response.stream.bytesToString();
        var parsedData = jsonDecode(responseData);
        url = parsedData['url'];
      }
      emit(UploadImageSuccess());
    } catch (errorMessage) {
      emit(UploadImageFailure(errorMessage: errorMessage.toString()));
    }
  }

  registerAccount() async {
    try {
      emit(RegisterWithUploadImageLoading());
      var requestBody = jsonEncode({
        'username': userNameController.text,
        'url': url,
      });
      var response = await http.post(
        Uri.parse('https://your-api-url/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );
      if (response.statusCode == 200) {
        // Registration successful, handle the response
        emit(RegisterWithUploadImageSuccess());
      } else {
        // Registration failed, handle the error
        emit(RegisterWithUploadImageFailure(
            errorMessage: 'Registration failed. Please try again.'));
      }
    } catch (errorMessage) {
      emit(RegisterWithUploadImageFailure(
          errorMessage: errorMessage.toString()));
    }
  }
}
