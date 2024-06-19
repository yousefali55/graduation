import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/services/login.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_state.dart';
import 'dart:io'; // For handling network errors

class SignInEmailCubit extends Cubit<SignInEmailState> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInEmailCubit() : super(SignInEmailInitial());

  signInEmail() async {
    try {
      emit(SignInEmailLoading());
      var loginService = LoginService();
      var errorMessage = await loginService.loginUser(
        username: usernameController.text,
        password: passwordController.text,
      );
      if (errorMessage == null) {
        emit(SignInEmailSuccess());
      } else {
        emit(SignInEmailFailure(errorMessage: errorMessage));
      }
    } catch (e) {
      String userFriendlyMessage = 'Error logging in';
      if (e is SocketException) {
        userFriendlyMessage = _parseSocketException(e);
      } else {
        userFriendlyMessage = 'Error logging in: ${e.toString()}';
      }
      print('Error signing in: $e');
      emit(SignInEmailFailure(errorMessage: userFriendlyMessage));
    }
  }

  String _parseSocketException(SocketException e) {
    if (e.osError != null && e.osError!.message.isNotEmpty) {
      return 'Error: ${e.osError!.message}';
    }
    return 'Error: Network issue';
  }
}
