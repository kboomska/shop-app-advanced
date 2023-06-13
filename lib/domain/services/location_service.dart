import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  late double _latitude;
  late double _longitude;

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 15));
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      throw 'Ошибка геолокации: $e';
    }
  }

  Future<void> getAddress() async {
    await _getCurrentLocation();
    print(_latitude);
    print(_longitude);

    final address = await placemarkFromCoordinates(_latitude, _longitude);
    print(address.first.name);
  }
}
