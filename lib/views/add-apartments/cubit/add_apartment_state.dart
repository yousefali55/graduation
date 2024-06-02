part of 'add_apartment_cubit.dart';

@immutable
sealed class AddApartmentState {}

final class AddApartmentInitial extends AddApartmentState {}
final class AddApartmentLoading extends AddApartmentState {}
final class AddApartmentSuccess extends AddApartmentState {}
final class AddApartmentFailure extends AddApartmentState {
  final String errorMessage;

  AddApartmentFailure({required this.errorMessage});
}
