import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_view_model.dart';
import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_widget.dart';
import 'package:shop_app/ui/widgets/category_screen/category_screen_view_model.dart';
import 'package:shop_app/ui/widgets/product_screen/product_screen_view_model.dart';
import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/domain/data_providers/shopping_cart_data_provider.dart';
import 'package:shop_app/ui/widgets/product_screen/product_screen_widget.dart';
import 'package:shop_app/ui/widgets/main_screen/main_screen_view_model.dart';
import 'package:shop_app/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:shop_app/ui/widgets/home_screen/home_screen_widget.dart';
import 'package:shop_app/Library/location_storage.dart';
import 'package:shop_app/domain/entity/dish.dart';

class ScreenFactory {
  final cartData = ShoppingCartDataProvider.instance;
  final locationStorage = LocationStorage.instance;

  Widget makeHomeScreen() {
    return const HomeScreenWidget();
  }

  Widget makeMainScreen() {
    return ChangeNotifierProvider(
      create: (context) => MainScreenViewModel(locationStorage),
      child: const MainScreenWidget(),
    );
  }

  Widget makeCategoryScreen(CategoryScreenConfiguration configuration) {
    return ChangeNotifierProvider(
      create: (context) => CategoryScreenViewModel(configuration),
      child: const CategoryScreenWidget(),
    );
  }

  Widget makeProductScreen(Dish dish) {
    return Provider(
      create: (context) => ProductScreenViewModel(dish, cartData),
      child: const ProductScreenWidget(),
    );
  }

  Widget makeShoppingCartScreen() {
    return ChangeNotifierProvider(
      create: (context) => ShoppingCartScreenViewModel(
        cartData,
        locationStorage,
      ),
      child: const ShoppingCartScreenWidget(),
    );
  }
}
