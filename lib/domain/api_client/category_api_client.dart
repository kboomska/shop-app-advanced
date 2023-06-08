import 'package:shop_app/domain/entity/categories_response.dart';
import 'package:shop_app/domain/api_client/network_client.dart';

class CategoryApiClient {
  final _networkClient = NetworkClient();

  Future<CategoriesResponse> getCategories() async {
    CategoriesResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = CategoriesResponse.fromJson(jsonMap);
      return jsonResponse;
    }

    final result = _networkClient.get(
      '/058729bd-1402-4578-88de-265481fd7d54',
      parser,
    );

    return result;
  }
}
