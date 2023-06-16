import 'package:flutter/material.dart';

import 'package:shop_app/domain/services/location_service_exception.dart';
import 'package:shop_app/domain/services/location_service.dart';

class LocationStorage {
  static final instance = LocationStorage._();
  final _locationService = LocationService();
  String? _location;

  LocationStorage._();

  String get location => _location ?? '';

  Future<void> getAddress(Locale locale) async {
    try {
      _location = await _locationService.getAddress(locale);
    } on LocationServiceException catch (e) {
      switch (e.type) {
        case LocationServiceExceptionType.permission:
          _location = 'Геолокация не доступна';
          break;
        case LocationServiceExceptionType.services:
          _location = 'Сервисы геолокации отключены';
          break;
        case LocationServiceExceptionType.other:
          _location = 'Не удалось установить местоположение';
          break;
      }
    } catch (_) {
      _location = 'Неизвестная ошибка, повторите попытку';
    }
  }
}
