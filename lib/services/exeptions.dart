class LocationServiceExeption implements Exception {
  final String message;
  LocationServiceExeption(this.message);
  @override
  String toString() {
    return message;
  }
}

class CheckAndRequestLocationPermessionExeption implements Exception {
  final String message;
  CheckAndRequestLocationPermessionExeption(this.message);
  @override
  String toString() {
    return message;
  }
}
