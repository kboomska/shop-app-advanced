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
import 'package:shop_app/Library/HttpClient/app_http_client.dart';
import 'package:shop_app/domain/api_client/dish_api_client.dart';
import 'package:shop_app/domain/api_client/network_client.dart';
import 'package:shop_app/domain/services/location_service.dart';
import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/domain/services/dish_service.dart';
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

  AppHttpClient _httpClient() => const AppHttpClientDefault();
  NetworkClientDefault _makeNetworkClient() => NetworkClientDefault(
        httpClient: _httpClient(),
      );

  DishApiClient _makeDishApiClient() => DishApiClientDefault(
        networkClient: _makeNetworkClient(),
      );
  DishService _makeDishService() => DishService(
        dishApiClient: _makeDishApiClient(),
      );

  CategoryScreenViewModel _makeCategoryScreenViewModel(
          CategoryScreenConfiguration configuration) =>
      CategoryScreenViewModel(
        configuration: configuration,
        screenFactory: _makeScreenFactory(),
        dishProvider: _makeDishService(),
      );
}

class _ScreenFactoryDefault implements ScreenFactory {
  final _DIContainer diContainer;

  const _ScreenFactoryDefault(this.diContainer);

  @override
  Widget makeHomeScreen() {
    return HomeScreenWidget(screenFactory: this);
  }

  @override
  Widget makeMainScreenGenerateRoute() {
    return Navigator(
      onGenerateRoute: diContainer._makeShopAppNavigation().onGenerateRoute,
    );
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
      create: (context) => diContainer._makeCategoryScreenViewModel(
        configuration,
      ),
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
