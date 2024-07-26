import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_2/data/models/country.dart';
import 'package:sports_2/data/repository.dart';
import 'package:sports_2/presentation/cubit/country_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final Repository repository;
  int? selectedCountryId;
  CountriesCubit(this.repository) : super(CountriesInitial());
  List<Country>? countries;

  void fetchCountries() async {
    try {
      emit(CountriesLoading());
      final countries = await repository.fetchCountries();
      this.countries = countries;
      emit(CountriesLoaded(countries: countries));
    } catch (e) {
      emit(CountriesError(message: e.toString()));
    }
  }
}
