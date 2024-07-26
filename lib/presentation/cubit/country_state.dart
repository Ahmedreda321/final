//part of 'countries_cubit.dart';

import 'package:sports_2/data/models/country.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountryId extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<Country> countries;

  CountriesLoaded({required this.countries});
}

class CountriesError extends CountriesState {
  final String message;

  CountriesError({required this.message});
}
