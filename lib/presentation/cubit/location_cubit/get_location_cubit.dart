// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:meta/meta.dart';
import 'package:sports_2/data/repository.dart';
import 'package:sports_2/services/exeptions.dart';
import 'package:sports_2/services/location_info.dart';

part 'get_location_state.dart';

class GetLocationCubitCubit extends Cubit<GetLocationCubitState> {
  GetLocationCubitCubit(this.repository) : super(GetLocationCubitInitial());
  final Repository repository;
  Future<void> getLocation() async {
    try {
      emit(GetLocationCubitLoading());
      LocationInfo locationData = await repository.fetchLocationData();

      String country = await getCountryFromLatLng(
          locationData.latitude!, locationData.longitude!);
      emit(GetLocationCubitSuccess(country));
    } on LocationServiceDisabledException catch (e) {
      emit(GetLocationCubitFailure(e.toString()));
    } on CheckAndRequestLocationPermessionExeption catch (e) {
      emit(GetLocationCubitFailure(e.toString()));
    } catch (e) {
      emit(GetLocationCubitFailure(e.toString()));
    }
  }

  Future<String> getCountryFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;

      return place.country ?? '';
    } catch (e) {
      return '';
    }
  }
}
