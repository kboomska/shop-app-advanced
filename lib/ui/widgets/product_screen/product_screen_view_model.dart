import 'package:flutter/material.dart';

import 'package:shop_app/domain/data_providers/shopping_cart_data_provider.dart';
import 'package:shop_app/domain/entity/dish.dart';

class ProductScreenViewModel {
  ShoppingCartDataProvider cartData;
  final Dish dish;

  ProductScreenViewModel(
    this.dish,
    this.cartData,
  );

  void addToCart(BuildContext context) {
    cartData.addShoppingCartItem(
      id: dish.id,
      name: dish.name,
      imageUrl: dish.imageUrl,
      price: dish.price,
      weight: dish.weight,
    );
    Navigator.of(context).pop();
  }
}
