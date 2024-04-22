part of 'get_profile_info_cubit.dart';

@immutable
sealed class GetProfileInfoState {}

final class GetProfileInfoInitial extends GetProfileInfoState {}

final class GetProfileInfoSuccess extends GetProfileInfoState {
  final ProfileModel profileModel;

  GetProfileInfoSuccess({required this.profileModel});
}

final class GetProfileInfoLoading extends GetProfileInfoState {}

final class GetProfileInfoFailure extends GetProfileInfoState {
  final String errorMessage;

  GetProfileInfoFailure({required this.errorMessage});
}
