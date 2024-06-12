import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GetOwnerApartmentsState {}

class GetOwnerApartmentsInitial extends GetOwnerApartmentsState {}

class GetOwnerApartmentsLoading extends GetOwnerApartmentsState {}

class GetOwnerApartmentsSuccess extends GetOwnerApartmentsState {
  final List<ApartmentModel> apartments;

  GetOwnerApartmentsSuccess(this.apartments);
}

class GetOwnerApartmentsFailure extends GetOwnerApartmentsState {
  final String errorMessage;

  GetOwnerApartmentsFailure({required this.errorMessage});
}

class ApartmentDeleted extends GetOwnerApartmentsState {}

class ApartmentUpdated extends GetOwnerApartmentsState {}
