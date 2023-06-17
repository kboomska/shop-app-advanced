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
import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/ui/widgets/app/shop_app.dart';
import 'package:shop_app/domain/entity/dish.dart';
import 'package:shop_app/main.dart';

AppFactory makeShopAppFactory() => _ShopAppFactoryDefault();

class _ShopAppFactoryDefault implements AppFactory {
  final _diContainer = _DIContainer();

  _ShopAppFactoryDefault();

  @override
  Widget makeShopApp() => ShopApp(
        navigation: _diContainer._makeShopAppNavigation(),
      );
}

class _DIContainer {
  final cartData = ShoppingCartDataProvider();
  final locationService = LocationService();

  _DIContainer();

  ScreenFactory _makeScreenFactory() => _ScreenFactoryDefault(this);
  ShopAppNavigation _makeShopAppNavigation() => MainNavigation(
        screenFactory: _makeScreenFactory(),
      );
}

class _ScreenFactoryDefault implements ScreenFactory {
  final _DIContainer diContainer;

  const _ScreenFactoryDefault(this.diContainer);

  @override
  Widget makeHomeScreen() {
    return const HomeScreenWidget();
  }

  @override
  Widget makeMainScreen() {
    return ChangeNotifierProvider(
      create: (context) => MainScreenViewModel(diContainer.locationService),
      child: const MainScreenWidget(),
    );
  }

  @override
  Widget makeCategoryScreen(CategoryScreenConfiguration configuration) {
    return ChangeNotifierProvider(
      create: (context) => CategoryScreenViewModel(configuration),
      child: const CategoryScreenWidget(),
    );
  }

  @override
  Widget makeProductScreen(Dish dish) {
    return Provider(
      create: (context) => ProductScreenViewModel(dish, diContainer.cartData),
      child: const ProductScreenWidget(),
    );
  }

  @override
  Widget makeShoppingCartScreen() {
    return ChangeNotifierProvider(
      create: (context) => ShoppingCartScreenViewModel(
        diContainer.cartData,
        diContainer.locationService,
      ),
      child: const ShoppingCartScreenWidget(),
    );
  }
}
