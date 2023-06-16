import 'dart:convert';
import 'dart:io';

import 'package:shop_app/domain/api_client/api_client_exception.dart';

class NetworkClient {
  final _client = HttpClient();

  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  ) async {
    final url = Uri.parse('$host$path');

    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
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
