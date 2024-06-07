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

// State for when photos are added
class AddApartmentPhotosAdded extends AddApartmentState {
  final List<File> photos;
  AddApartmentPhotosAdded(this.photos);
}
