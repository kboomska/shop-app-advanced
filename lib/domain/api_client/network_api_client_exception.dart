enum NetworkApiClientExceptionType { network, other }

class NetworkApiClientException implements Exception {
  final NetworkApiClientExceptionType type;

  NetworkApiClientException(this.type);
}
