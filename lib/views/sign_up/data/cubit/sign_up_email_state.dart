part of 'sign_up_email_cubit.dart';

@immutable
sealed class SignUpEmailState {}

final class SignUpEmailInitial extends SignUpEmailState {}
final class SignUpEmailLaoding extends SignUpEmailState {}
final class SignUpEmailSuccess extends SignUpEmailState {}
final class SignUpEmailFailure extends SignUpEmailState {
  final String errorMessage;
  SignUpEmailFailure({required this.errorMessage});
}
