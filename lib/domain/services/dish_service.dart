import 'package:shop_app/domain/api_client/dish_api_client.dart';
import 'package:shop_app/domain/entity/dishes_response.dart';
import 'package:shop_app/ui/widgets/category_screen/category_screen_view_model.dart';

class DishService implements CategoryScreenViewModelDishProvider {
  final DishApiClient dishApiClient;

  DishService({
    required this.dishApiClient,
  });

  @override
  Future<DishesResponse> categoryScreenDishes() async {
    return dishApiClient.getDishes();
  }
}
