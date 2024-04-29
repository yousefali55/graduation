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

  final Dio dio = Dio();

  Future<void> addApartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      emit(AddApartmentLoading());

      final data = {
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
      };

      final response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('${response.data}=================================${response.statusCode}');
        emit(AddApartmentSuccess());
      } else {
        emit(AddApartmentFailure(
          errorMessage: 'Failed with status code ${response.statusCode}',
        ));
      }
    } catch (e) {
      print(e.toString());
      emit(AddApartmentFailure(errorMessage: e.toString()));
    }
  }
}
