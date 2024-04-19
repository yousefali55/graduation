import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/services/login.dart';
part 'sign_in_email_state.dart';

class SignInEmailCubit extends Cubit<SignInEmailState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInEmailCubit() : super(SignInEmailInitial());

  signInEmail() async {
    try {
      emit(SignInEmailLoading());
      var loginService = LoginService(); // Instantiate your login service
      var errorMessage = await loginService.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
      if (errorMessage == null) {
        emit(SignInEmailSuccess());
      } else {
        emit(SignInEmailFailure(errorMessage: errorMessage));
      }
    } catch (e) {
      emit(SignInEmailFailure(
          errorMessage: 'Error signing in: ${e.toString()}'));
    }
  }
}
