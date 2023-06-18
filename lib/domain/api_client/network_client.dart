import 'dart:convert';
import 'dart:io';

import 'package:shop_app/domain/api_client/network_api_client_exception.dart';
import 'package:shop_app/Library/HttpClient/app_http_client.dart';

abstract class NetworkClient {
  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  );
}

class NetworkClientDefault implements NetworkClient {
  final AppHttpClient httpClient;

  NetworkClientDefault({
    required this.httpClient,
  });

  @override
  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  ) async {
    final url = Uri.parse('$host$path');

    try {
      final request = await httpClient.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw NetworkApiClientException(NetworkApiClientExceptionType.network);
    } catch (_) {
      throw NetworkApiClientException(NetworkApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((jsonStrings) {
      final result = jsonStrings.join();
      return result;
    }).then((jsonString) => json.decode(jsonString));
  }
}
