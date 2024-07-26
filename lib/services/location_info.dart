import 'package:location/location.dart';

class LocationInfo {
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final double? verticalAccuracy;
  final double? altitude;
  final double? speed;
  final double? speedAccuracy;
  final double? heading;
  final double? time;

  final bool? isMock;
  final double? headingAccuracy;
  final double? elapsedRealtimeNanos;
  final double? elapsedRealtimeUncertaintyNanos;
  final int? satelliteNumber;
  final String? provider;

  LocationInfo(
      {required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.verticalAccuracy,
      required this.altitude,
      required this.speed,
      required this.speedAccuracy,
      required this.heading,
      required this.time,
      required this.isMock,
      required this.headingAccuracy,
      required this.elapsedRealtimeNanos,
      required this.elapsedRealtimeUncertaintyNanos,
      required this.satelliteNumber,
      required this.provider});

  factory LocationInfo.fromLocationData(LocationData locationData) {
    return LocationInfo(
        accuracy: locationData.accuracy,
        altitude: locationData.altitude,
        elapsedRealtimeNanos: locationData.elapsedRealtimeNanos,
        elapsedRealtimeUncertaintyNanos:
            locationData.elapsedRealtimeUncertaintyNanos,
        heading: locationData.heading,
        headingAccuracy: locationData.headingAccuracy,
        isMock: locationData.isMock,
        latitude: locationData.latitude,
        longitude: locationData.longitude,
        provider: locationData.provider,
        satelliteNumber: locationData.satelliteNumber,
        speed: locationData.speed,
        speedAccuracy: locationData.speedAccuracy,
        verticalAccuracy: locationData.verticalAccuracy,
        time: locationData.time);
  }
}
