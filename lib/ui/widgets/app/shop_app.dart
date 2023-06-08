import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shop_app/ui/navigation/main_navigation.dart';

class ShopApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
      ],
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.home,
    );
  }
}
