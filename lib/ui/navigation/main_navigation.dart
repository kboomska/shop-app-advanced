import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/ui/navigation/main_navigation_route_names.dart';
import 'package:shop_app/domain/factories/screen_factory.dart';
import 'package:shop_app/ui/widgets/app/shop_app.dart';

class MainNavigation implements ShopAppNavigation {
  static final _screenFactory = ScreenFactory();

  const MainNavigation();

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        MainNavigationRouteNames.home: (_) => _screenFactory.makeHomeScreen(),
      };
  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.category:
        final configuration = settings.arguments as CategoryScreenConfiguration;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeCategoryScreen(configuration),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMainScreen(),
        );
    }
  }
}
