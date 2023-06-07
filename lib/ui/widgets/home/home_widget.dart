import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/main/main_widget.dart';
import 'package:shop_app/theme/app_colors.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
        backgroundColor: AppColors.bottomNavigationBarBackground,
        selectedItemColor: AppColors.bottomNavigationBarSelected,
        unselectedItemColor: AppColors.bottomNavigationBarUnselected,
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
            icon: const Icon(Icons.home_rounded),
            label: _bottomNavigationBarOptions[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: _bottomNavigationBarOptions[2],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: _bottomNavigationBarOptions[3],
          ),
        ],
        onTap: onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const MainWidget(),
          Center(
            child: Text(_bottomNavigationBarOptions[1]),
          ),
          Center(
            child: Text(_bottomNavigationBarOptions[2]),
          ),
          Center(
            child: Text(_bottomNavigationBarOptions[3]),
          ),
        ],
      ),
    );
  }
}
