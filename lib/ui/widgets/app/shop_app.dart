import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shop_app/ui/navigation/main_navigation_route_names.dart';
import 'package:shop_app/theme/app_colors.dart';

abstract class ShopAppNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings);
  Map<String, Widget Function(BuildContext)> get routes;
}

class ShopApp extends StatelessWidget {
  final ShopAppNavigation navigation;

  const ShopApp({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBackground,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.bottomNavigationBarBackground,
          selectedItemColor: AppColors.bottomNavigationBarSelected,
          unselectedItemColor: AppColors.bottomNavigationBarUnselected,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
      ],
      routes: navigation.routes,
      initialRoute: MainNavigationRouteNames.home,
    );
  }
}
