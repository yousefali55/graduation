part of 'register_with_upload_image_cubit.dart';

sealed class RegisterWithUploadImageState {}

final class RegisterWithUploadImageInitial extends RegisterWithUploadImageState {}
final class UploadImageInitial extends RegisterWithUploadImageState {}
final class UploadImageLoading extends RegisterWithUploadImageState {}
final class UploadImageSuccess extends RegisterWithUploadImageState {}
final class UploadImageFailure extends RegisterWithUploadImageState {
  final String errorMessage;
  UploadImageFailure({required this.errorMessage});
}
final class RegisterWithUploadImageLoading extends RegisterWithUploadImageState {}
final class RegisterWithUploadImageSuccess extends RegisterWithUploadImageState {}
final class RegisterWithUploadImageFailure extends RegisterWithUploadImageState {
  final String errorMessage;
  RegisterWithUploadImageFailure({required this.errorMessage});
}
