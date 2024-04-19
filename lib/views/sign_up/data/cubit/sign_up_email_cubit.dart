import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/services/register.dart';
part 'sign_up_email_state.dart';

class SignUpEmailCubit extends Cubit<SignUpEmailState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  String? _userType; // Private variable to hold user type

  SignUpEmailCubit() : super(SignUpEmailInitial());

  // Getter for user type
  String? get userType => _userType;

  // Method to set user type
  void setUserType(String type) {
    _userType = type;
  }

  bool isFormValid() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        password2Controller.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        _userType != null;
  }

  signUpEmail() async {
    try {
      emit(SignUpEmailLoading());
      var registerService = RegisterService();
      var errorMessage = await registerService.registerUser(
        email: emailController.text,
        password: passwordController.text,
        password2: password2Controller.text,
        username: usernameController.text,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        userType: _userType ?? '',
      );
      if (errorMessage == null) {
        emit(SignUpEmailSuccess());
      } else {
        emit(SignUpEmailFailure(errorMessage: errorMessage));
      }
    } catch (e) {
      emit(SignUpEmailFailure(
          errorMessage: 'Error registering user: ${e.toString()}'));
    }
  }
}
