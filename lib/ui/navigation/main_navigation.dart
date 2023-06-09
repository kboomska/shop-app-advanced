import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const home = '/';
  static const category = '/category';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.home: (_) => _screenFactory.makeHomeScreen(),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.category:
        final configuration = settings.arguments as CategoryScreenConfiguration;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeCategoryScreen(configuration),
        );
      default:
        const widget = Text('Navigation error!');
        return MaterialPageRoute(
          builder: (_) => widget,
        );
    }
  }
}
