import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  TextEditingController emailTextEditingController = TextEditingController();
  final String apiUrl = 'http://54.161.17.51:8000/api/request-reset-password/';

  Future<void> requestPasswordChange() async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        apiUrl,
        data: {
          'email': emailTextEditingController
              .text, // Extracting email from the controller
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json', 
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Password reset request successful");
        emit(ChangePasswordSuccess());
      } else {
        print("Unexpected status code: ${response.statusCode}");
        emit(ChangePasswordFailure(
            errorMessage: 'Unexpected status code: ${response.statusCode}'));
      }
    } catch (dioError) {
      if (dioError is DioException) {
        if (dioError.type == DioExceptionType.badResponse) {
          final statusCode = dioError.response?.statusCode;
          final errorData = dioError.response?.data;

          emit(ChangePasswordFailure(
            errorMessage: 'Error ${statusCode}: ${errorData}',
          ));
        } else {
          emit(ChangePasswordFailure(
            errorMessage: 'Dio error: ${dioError.type} - ${dioError.message}',
          ));
        }
      } else {
        emit(ChangePasswordFailure(
            errorMessage: 'An error occurred: ${dioError.toString()}'));
      }
    }
  }
}
