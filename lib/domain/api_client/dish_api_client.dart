import 'package:shop_app/domain/api_client/network_client.dart';
import 'package:shop_app/domain/entity/dishes_response.dart';
import 'package:shop_app/configuration/configuration.dart';

class DishApiClient {
  final _networkClient = NetworkClient();

  Future<DishesResponse> getDishes() async {
    DishesResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = DishesResponse.fromJson(jsonMap);
      return jsonResponse;
    }

    final result = _networkClient.get(
      Configuration.host,
      '/aba7ecaa-0a70-453b-b62d-0e326c859b3b',
      parser,
    );

    return result;
  }
}
