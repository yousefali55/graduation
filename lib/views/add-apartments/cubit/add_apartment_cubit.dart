import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_apartment_state.dart';

class AddApartmentCubit extends Cubit<AddApartmentState> {
  AddApartmentCubit() : super(AddApartmentInitial());
  final String apiUrl = 'http://54.161.17.51:8000/api/apartments/create/';

  final TextEditingController titleEnText = TextEditingController();
  final TextEditingController descriptionEnText = TextEditingController();
  final TextEditingController addressText = TextEditingController();
  final TextEditingController priceText = TextEditingController();
  final TextEditingController roomsText = TextEditingController();
  final TextEditingController sizeText = TextEditingController();
  final TextEditingController bedsText = TextEditingController();
  final TextEditingController bathroomText = TextEditingController();
  final TextEditingController viewText = TextEditingController();
  final TextEditingController finishingTypeText = TextEditingController();
  final TextEditingController floorNumberText = TextEditingController();
  final TextEditingController yearOfConstructionText = TextEditingController();
  final TextEditingController ownerUsernameText = TextEditingController();
  final TextEditingController ownerPhoneNumberText = TextEditingController();
  final TextEditingController ownerEmailText = TextEditingController();

  final Dio dio = Dio();
  List<File> selectedPhotos = [];

  bool _areFieldsValid() {
    bool valid = titleEnText.text.isNotEmpty &&
        descriptionEnText.text.isNotEmpty &&
        addressText.text.isNotEmpty &&
        priceText.text.isNotEmpty &&
        roomsText.text.isNotEmpty &&
        sizeText.text.isNotEmpty &&
        bedsText.text.isNotEmpty &&
        bathroomText.text.isNotEmpty &&
        viewText.text.isNotEmpty &&
        finishingTypeText.text.isNotEmpty &&
        floorNumberText.text.isNotEmpty &&
        yearOfConstructionText.text.isNotEmpty &&
        selectedPhotos.isNotEmpty;

    return valid;
  }

  Future<void> addApartment() async {
    if (!_areFieldsValid()) {
      emit(AddApartmentFailure(errorMessage: "Please, fill all fields"));
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      emit(AddApartmentLoading());

      // Create a map to hold form data
      Map<String, dynamic> formData = {
        'title': 'N/A',
        'title_en': titleEnText.text,
        'title_ar': 'N/A',
        'description': 'N/A',
        'description_en': descriptionEnText.text,
        'description_ar': 'N/A',
        'address': addressText.text,
        'price': double.tryParse(priceText.text) ?? 0.0,
        'rooms': int.tryParse(roomsText.text) ?? 0,
        'size': double.tryParse(sizeText.text) ?? 0.0,
        'beds': int.tryParse(bedsText.text) ?? 0,
        'bathrooms': int.tryParse(bathroomText.text) ?? 0,
        'view': viewText.text,
        'finishing_type': finishingTypeText.text,
        'floor_number': int.tryParse(floorNumberText.text) ?? 0,
        'year_of_construction': int.tryParse(yearOfConstructionText.text) ?? 0,
        'owner_username': '',
        'owner_phone_number': int.tryParse(ownerPhoneNumberText.text) ?? 0,
        'owner_email': '',
      };

      // Create FormData object and add the photos
      List<MultipartFile> photoFiles = [];
      for (File photo in selectedPhotos) {
        photoFiles.add(await MultipartFile.fromFile(photo.path,
            filename: photo.path.split('/').last));
      }

      FormData formDataWithPhotos = FormData.fromMap({
        ...formData,
        'photos': photoFiles,
      });

      final response = await dio.post(
        apiUrl,
        data: formDataWithPhotos,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        emit(AddApartmentSuccess());
      } else {
        emit(AddApartmentFailure(
          errorMessage: 'Failed with status code ${response.statusCode}',
        ));
      }
    } catch (e) {
      emit(AddApartmentFailure(errorMessage: e.toString()));
    }
  }

  void addPhoto(File photo) {
    selectedPhotos.add(photo);
    emit(AddApartmentPhotoSelected(photo));
  }

  void removePhoto(File photo) {
    selectedPhotos.remove(photo);
    emit(AddApartmentPhotoRemoved());
  }
}
