import 'package:flutter/material.dart';
import 'package:shop_app/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const home = '/';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.home: (_) => _screenFactory.makeHomeScreen(),
  };
}
