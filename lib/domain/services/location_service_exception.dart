enum LocationServiceExceptionType { permission, services, other }

class LocationServiceException implements Exception {
  final LocationServiceExceptionType type;

  LocationServiceException(this.type);
}
