import 'package:flutter/material.dart';

@immutable
abstract class SignUpEmailState {}

class SignUpEmailInitial extends SignUpEmailState {}

class SignUpEmailLoading extends SignUpEmailState {}

class SignUpEmailSuccess extends SignUpEmailState {}

class SignUpEmailFailure extends SignUpEmailState {
  final String errorMessage;
  SignUpEmailFailure({required this.errorMessage});
}

class SignUpFormStatusChanged extends SignUpEmailState {
  final bool isSignUpButtonEnabled;
  SignUpFormStatusChanged({required this.isSignUpButtonEnabled});
}
