import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/ui/navigation/main_navigation_route_names.dart';
import 'package:shop_app/ui/widgets/app/shop_app.dart';
import 'package:shop_app/domain/entity/dish.dart';

abstract class ScreenFactory {
  Widget makeCategoryScreen(CategoryScreenConfiguration configuration);
  Widget makeMainScreenGenerateRoute();
  Widget makeProductScreen(Dish dish);
  Widget makeShoppingCartScreen();
  Widget makeHomeScreen();
  Widget makeMainScreen();
}

class MainNavigation implements ShopAppNavigation {
  final ScreenFactory screenFactory;

  const MainNavigation({required this.screenFactory});

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        MainNavigationRouteNames.home: (_) => screenFactory.makeHomeScreen(),
      };
  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.category:
        final configuration = settings.arguments as CategoryScreenConfiguration;
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeCategoryScreen(configuration),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeMainScreen(),
        );
    }
  }
}
