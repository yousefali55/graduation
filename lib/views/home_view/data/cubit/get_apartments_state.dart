part of 'get_apartments_cubit.dart';

sealed class GetApartmentsState {}

final class GetApartmentsInitial extends GetApartmentsState {}

final class GetApartmentsLoading extends GetApartmentsState {}

final class GetApartmentsSuccess extends GetApartmentsState {}

final class GetApartmentsFailure extends GetApartmentsState {
  final String errorMessage;

  GetApartmentsFailure({required this.errorMessage});
}
