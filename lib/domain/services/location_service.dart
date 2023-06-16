import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:shop_app/domain/services/location_service_exception.dart';

class LocationService {
  Future<String?> getAddress(Locale locale) async {
    Position position = await _determinePosition();

    final address = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: locale.toLanguageTag(),
    );
    return address.first.locality;
  }

  Future<Position> _getCurrentLocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 15));
    } catch (e) {
      throw LocationServiceExceptionType.other;
    }
    return position;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceExceptionType.services;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationServiceExceptionType.permission;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationServiceExceptionType.permission;
    }

    return await _getCurrentLocation();
  }
}
