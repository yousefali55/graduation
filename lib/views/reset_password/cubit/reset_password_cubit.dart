import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
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
            'Content-Type': 'application/json', // Ensure correct content type
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Password reset request successful");
        emit(ResetPasswordSuccess());
      } else {
        print("Unexpected status code: ${response.statusCode}");
        emit(ResetPasswordFailure(
            errorMessage: 'Unexpected status code: ${response.statusCode}'));
      }
    } catch (dioError) {
      if (dioError is DioException) {
        if (dioError.type == DioExceptionType.badResponse) {
          final statusCode = dioError.response?.statusCode;
          final errorData = dioError.response?.data;

          emit(ResetPasswordFailure(
            errorMessage: 'Error $statusCode: $errorData',
          ));
        } else {
          emit(ResetPasswordFailure(
            errorMessage: 'Dio error: ${dioError.type} - ${dioError.message}',
          ));
        }
      } else {
        emit(ResetPasswordFailure(
            errorMessage: 'An error occurred: ${dioError.toString()}'));
      }
    }
  }
}
