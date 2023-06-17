import 'package:flutter/material.dart';

import 'package:shop_app/domain/api_client/location_api_client_exception.dart';
import 'package:shop_app/domain/api_client/location_api_client.dart';

class LocationService {
  final _locationService = LocationApiClient();
  String? _location;

  LocationService();

  String get location => _location ?? '';

  Future<void> getAddress(Locale locale) async {
    try {
      _location = await _locationService.getAddress(locale);
    } on LocationApiClientException catch (e) {
      switch (e.type) {
        case LocationApiClientExceptionType.permission:
          _location = 'Геолокация не доступна';
          break;
        case LocationApiClientExceptionType.services:
          _location = 'Сервисы геолокации отключены';
          break;
        case LocationApiClientExceptionType.other:
          _location = 'Не удалось установить местоположение';
          break;
      }
    } catch (_) {
      _location = 'Неизвестная ошибка, повторите попытку';
    }
  }
}
