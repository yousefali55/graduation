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

  final TextEditingController titleText = TextEditingController();
  final TextEditingController titleEnText = TextEditingController();
  final TextEditingController titleArText = TextEditingController();
  final TextEditingController descriptionText = TextEditingController();
  final TextEditingController descriptionEnText = TextEditingController();
  final TextEditingController descriptionArText = TextEditingController();
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
  File? selectedPhoto;

  Future<void> addApartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      emit(AddApartmentLoading());

      if (selectedPhoto == null) {
        emit(AddApartmentFailure(errorMessage: "Please select a photo"));
        return;
      }

      // Create a map to hold form data
      Map<String, dynamic> formData = {
        'title': titleText.text,
        'title_en': titleEnText.text,
        'title_ar': titleArText.text,
        'description': descriptionText.text,
        'description_en': descriptionEnText.text,
        'description_ar': descriptionArText.text,
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
        'owner_phone_number': '',
        'owner_email': '',
      };

      // Create FormData object and add the photo
      FormData formDataWithPhoto = FormData.fromMap({
        ...formData,
        'photos': await MultipartFile.fromFile(selectedPhoto!.path,
            filename: selectedPhoto!.path.split('/').last),
      });

      final response = await dio.post(
        apiUrl,
        data: formDataWithPhoto,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print(jsonEncode(response.data));
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
    selectedPhoto = photo;
    emit(AddApartmentPhotoSelected(photo));
  }

  void removePhoto() {
    selectedPhoto = null;
    emit(AddApartmentPhotoRemoved());
  }
}
