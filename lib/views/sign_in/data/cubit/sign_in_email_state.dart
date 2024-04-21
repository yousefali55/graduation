import 'package:meta/meta.dart';

@immutable
abstract class SignInEmailState {}

class SignInEmailInitial extends SignInEmailState {}

class SignInEmailLoading extends SignInEmailState {}

class SignInEmailSuccess extends SignInEmailState {}

class SignInEmailFailure extends SignInEmailState {
  final String errorMessage;
  SignInEmailFailure({required this.errorMessage});
}
