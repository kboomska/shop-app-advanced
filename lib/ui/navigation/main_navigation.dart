import 'package:flutter/material.dart';

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
        final arguments = settings.arguments;
        final categoryId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeCategoryScreen(categoryId),
        );

      default:
        const widget = Text('Navigation error!');
        return MaterialPageRoute(
          builder: (_) => widget,
        );
    }
  }
}
