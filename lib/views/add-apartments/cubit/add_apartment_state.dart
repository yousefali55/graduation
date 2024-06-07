part of 'add_apartment_cubit.dart';

@immutable
abstract class AddApartmentState {}

class AddApartmentInitial extends AddApartmentState {}

class AddApartmentLoading extends AddApartmentState {}

class AddApartmentSuccess extends AddApartmentState {}

class AddApartmentFailure extends AddApartmentState {
  final String errorMessage;
  AddApartmentFailure({required this.errorMessage});
}

class AddApartmentPhotoSelected extends AddApartmentState {
  final File photo;
  AddApartmentPhotoSelected(this.photo);
}

class AddApartmentPhotoRemoved extends AddApartmentState {}
