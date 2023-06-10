import 'package:shop_app/domain/entity/dish.dart';

class ProductScreenViewModel {
  final Dish dish;

  ProductScreenViewModel(this.dish);

  void addToCart() {
    print('Add to cart');
  }
}
