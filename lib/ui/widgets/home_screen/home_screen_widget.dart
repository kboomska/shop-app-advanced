import 'package:flutter/material.dart';

import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/resources/resources.dart';
import 'package:shop_app/theme/app_colors.dart';

class HomeScreenWidget extends StatefulWidget {
  final ScreenFactory screenFactory;

  const HomeScreenWidget({super.key, required this.screenFactory});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
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
      bottomNavigationBar: bottomNavigationBarHandler(
        index: _selectedTab,
        labelList: _bottomNavigationBarOptions,
        onSelectTab: onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          widget.screenFactory.makeMainScreenGenerateRoute(),
          Center(
            child: Text(_bottomNavigationBarOptions[1]),
          ),
          widget.screenFactory.makeShoppingCartScreen(),
          Center(
            child: Text(_bottomNavigationBarOptions[3]),
          ),
        ],
      ),
    );
  }
}

Widget bottomNavigationBarHandler({
  required int index,
  required List<String> labelList,
  required Function(int) onSelectTab,
}) {
  return Container(
    height: 69,
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: AppColors.bottomNavigationBarBorder,
          width: 1,
        ),
      ),
    ),
    child: BottomNavigationBar(
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      iconSize: 24,
      elevation: 0,
      items: [
        makeItem(
          assetImage: ShopAppIcons.home,
          label: labelList[0],
        ),
        makeItem(
          assetImage: ShopAppIcons.search,
          label: labelList[1],
        ),
        makeItem(
          assetImage: ShopAppIcons.cart,
          label: labelList[2],
        ),
        makeItem(
          assetImage: ShopAppIcons.profile,
          label: labelList[3],
        ),
      ],
      onTap: onSelectTab,
    ),
  );
}

BottomNavigationBarItem makeItem({
  required String assetImage,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          assetImage,
          color: AppColors.bottomNavigationBarUnselected,
        ),
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          assetImage,
          color: AppColors.bottomNavigationBarSelected,
        ),
      ),
    ),
    label: label,
  );
}
