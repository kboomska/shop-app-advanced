import 'package:flutter/material.dart';

import 'package:shop_app/ui/navigation/main_navigation.dart';

class ShopApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.home,
    );
  }
}
