import 'package:graduation/views/home_view/data/apartments_model.dart';

abstract class GetOwnerApartmentsState {}

class GetOwnerApartmentsInitial extends GetOwnerApartmentsState {}

class GetOwnerApartmentsLoading extends GetOwnerApartmentsState {}

class GetOwnerApartmentsSuccess extends GetOwnerApartmentsState {
  final List<ApartmentModel> apartments;

  GetOwnerApartmentsSuccess({
    required this.apartments,
  });
}

class GetOwnerApartmentsFailure extends GetOwnerApartmentsState {
  final String errorMessage;

  GetOwnerApartmentsFailure({required this.errorMessage});
}
