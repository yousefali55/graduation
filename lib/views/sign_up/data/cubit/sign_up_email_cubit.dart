import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/services/register.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_state.dart';

class SignUpEmailCubit extends Cubit<SignUpEmailState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  String _userType = ''; // Private variable to hold user type
  bool _passwordsMatch = false;
  bool _isSignUpButtonEnabled = false;

  SignUpEmailCubit() : super(SignUpEmailInitial());

  // Getter for user type
  String get userType => _userType;

  // Method to set user type
  void setUserType(String? type) {
    _userType = type ?? '';
    checkFormValidity();
  }

  // Check if passwords match
  void checkPasswordMatch() {
    _passwordsMatch = passwordController.text == password2Controller.text;
    checkFormValidity();
  }

  // Check overall form validity
  void checkFormValidity() {
    _isSignUpButtonEnabled = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        password2Controller.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        _userType.isNotEmpty &&
        _passwordsMatch;
    emit(
        SignUpFormStatusChanged(isSignUpButtonEnabled: _isSignUpButtonEnabled));
  }

  // Getter for sign-up button status
  bool isSignUpButtonEnabled() {
    return _isSignUpButtonEnabled;
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
        first_name: firstnameController.text,
        last_name: lastnameController.text,
        userType: _userType,
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

  // Method to reset all fields
  void resetFields() {
    emailController.clear();
    passwordController.clear();
    password2Controller.clear();
    usernameController.clear();
    firstnameController.clear();
    lastnameController.clear();
    _userType = '';
    _passwordsMatch = false;
    checkFormValidity(); // Make sure the form validity is updated
  }
}
