import 'package:shop_app/domain/api_client/dish_api_client.dart';
import 'package:shop_app/domain/entity/dishes_response.dart';

class DishService {
  final _dishApiClient = DishApiClient();

  Future<DishesResponse> categoryScreenDishes() async {
    return _dishApiClient.getDishes();
  }
}
