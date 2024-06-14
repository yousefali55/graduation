import 'package:graduation/views/home_view/data/apartments_model.dart';

abstract class EditOwnerApartmentState {}

class EditOwnerApartmentInitial extends EditOwnerApartmentState {}

class EditOwnerApartmentLoading extends EditOwnerApartmentState {}

class EditOwnerApartmentSuccess extends EditOwnerApartmentState {
  final ApartmentModel apartment;

  EditOwnerApartmentSuccess({required this.apartment});
}

class EditOwnerApartmentFailure extends EditOwnerApartmentState {
  final String errorMessage;

  EditOwnerApartmentFailure({required this.errorMessage});
}
