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
import 'package:shop_app/domain/services/location_service.dart';
import 'package:shop_app/domain/entity/dish.dart';

class ScreenFactory {
  final cartData = ShoppingCartDataProvider.instance;
  final locationService = LocationService.instance;

  Widget makeHomeScreen() {
    return const HomeScreenWidget();
  }

  Widget makeMainScreen() {
    return ChangeNotifierProvider(
      create: (context) => MainScreenViewModel(locationService),
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
        locationService,
      ),
      child: const ShoppingCartScreenWidget(),
    );
  }
}
