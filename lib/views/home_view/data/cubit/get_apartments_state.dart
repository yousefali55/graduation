import 'package:graduation/views/home_view/data/apartments_model.dart';

abstract class GetApartmentsState {}

class GetApartmentsInitial extends GetApartmentsState {}

class GetApartmentsLoading extends GetApartmentsState {}

class GetApartmentsSuccess extends GetApartmentsState {
  final List<ApartmentModel> apartments; // Define apartments list
  final List<ApartmentModel> favorites; // Define favorites list

  GetApartmentsSuccess({
    required this.apartments,
    required this.favorites,
  });
}

class GetApartmentsFailure extends GetApartmentsState {
  final String errorMessage;

  GetApartmentsFailure({required this.errorMessage});
}
