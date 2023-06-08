import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/theme/app_colors.dart';

class ShopApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.home,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
