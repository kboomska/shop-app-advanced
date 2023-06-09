import 'package:flutter/material.dart';

import 'package:shop_app/domain/factories/screen_factory.dart';
import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/theme/app_colors.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  static final mainNavigation = MainNavigation();
  static final screenFactory = ScreenFactory();

  int _selectedTab = 0;

  static const List<String> _bottomNavigationBarOptions = [
    'Главная',
    'Поиск',
    'Корзина',
    'Аккаунт',
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        iconSize: 20,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: _bottomNavigationBarOptions[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: _bottomNavigationBarOptions[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_basket_outlined),
            label: _bottomNavigationBarOptions[2],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            label: _bottomNavigationBarOptions[3],
          ),
        ],
        onTap: onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Navigator(
            onGenerateRoute: mainNavigation.onGenerateRoute,
          ),
          Center(
            child: Text(_bottomNavigationBarOptions[1]),
          ),
          screenFactory.makeShoppingCartScreen(),
          Center(
            child: Text(_bottomNavigationBarOptions[3]),
          ),
        ],
      ),
    );
  }
}
