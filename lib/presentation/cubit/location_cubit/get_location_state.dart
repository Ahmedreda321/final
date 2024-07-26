part of 'get_location_cubit.dart';

@immutable
sealed class GetLocationCubitState {}

final class GetLocationCubitInitial extends GetLocationCubitState {}

final class GetLocationCubitLoading extends GetLocationCubitState {}

final class GetLocationCubitSuccess extends GetLocationCubitState {
  final String  countryName;

  GetLocationCubitSuccess(this.countryName);
}

final class GetLocationCubitFailure extends GetLocationCubitState {
  final String errMessage;

  GetLocationCubitFailure(this.errMessage);
}
