import 'package:dio/dio.dart';
import 'package:sports_2/services/location_info.dart';
import 'package:sports_2/services/location_service.dart';
import 'models/country.dart';

class Repository {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://apiv2.allsportsapi.com/football/'));
  final String apiKey =
      '273261390740d5254a31cfa918ff4ffcfdb4398bdb7424be989f7ce507e03322';
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await _dio.get(
          'https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=273261390740d5254a31cfa918ff4ffcfdb4398bdb7424be989f7ce507e03322');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<LocationInfo> fetchLocationData() async {
    LocationService locationService = LocationService();
    LocationInfo result = await locationService.getLocationData();
    return result;
  }
}
