import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_view_model.dart';
import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_widget.dart';
import 'package:shop_app/ui/widgets/category_screen/category_screen_view_model.dart';
import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/ui/widgets/main_screen/main_screen_view_model.dart';
import 'package:shop_app/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:shop_app/ui/widgets/home_screen/home_screen_widget.dart';

class ScreenFactory {
  Widget makeHomeScreen() {
    return const HomeScreenWidget();
  }

  Widget makeMainScreen() {
    return ChangeNotifierProvider(
      create: (context) => MainScreenViewModel(),
      child: const MainScreenWidget(),
    );
  }

  Widget makeCategoryScreen(CategoryScreenConfiguration configuration) {
    return ChangeNotifierProvider(
      create: (context) => CategoryScreenViewModel(configuration),
      child: const CategoryScreenWidget(),
    );
  }

  Widget makeShoppingCartScreen() {
    return ChangeNotifierProvider(
      create: (context) => ShoppingCartScreenViewModel(),
      child: const ShoppingCartScreenWidget(),
    );
  }
}
