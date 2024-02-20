part of 'sign_in_email_cubit.dart';

sealed class SignInEmailState {}

final class SignInEmailInitial extends SignInEmailState {}
final class SignInEmailLaoding extends SignInEmailState {}
final class SignInEmailSuccess extends SignInEmailState {}
final class SignInEmailFailure extends SignInEmailState {
  final String errorMessage;
  SignInEmailFailure({required this.errorMessage});
}
