import 'dart:convert';
import 'dart:io';

import 'package:shop_app/configuration/configuration.dart';

class NetworkClient {
  final _client = HttpClient();

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser,
  ) async {
    final url = Uri.parse('${Configuration.host}$path');

    // try {
    final request = await _client.getUrl(url);
    final response = await request.close();
    final dynamic json = (await response.jsonDecode());
    final result = parser(json);
    return result;
    // } on SocketException {
    //   throw 'Ошибка соединения. Повторите попытку';
    // } catch (_) {
    //   throw 'Произошла неизвестаная ошибка';
    // }
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
