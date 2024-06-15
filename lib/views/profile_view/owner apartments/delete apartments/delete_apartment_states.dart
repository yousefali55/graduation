import 'package:equatable/equatable.dart';

abstract class DeleteOwnerApartmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteOwnerApartmentInitial extends DeleteOwnerApartmentState {}

class DeleteOwnerApartmentLoading extends DeleteOwnerApartmentState {}

class DeleteOwnerApartmentSuccess extends DeleteOwnerApartmentState {}

class DeleteOwnerApartmentFailure extends DeleteOwnerApartmentState {
  final String errorMessage;

  DeleteOwnerApartmentFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
