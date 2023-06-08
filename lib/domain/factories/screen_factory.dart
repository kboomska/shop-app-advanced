import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/main_screen/main_screen_view_model.dart';
import 'package:shop_app/ui/widgets/home_screen/home_screen_widget.dart';
import 'package:shop_app/ui/widgets/main_screen/main_screen_widget.dart';

class ScreenFactory {
  Widget makeHomeScreen() {
    return const HomeScreenWidget();
  }

  Widget makeMainScreen() {
    return Provider(
      create: (context) => MainScreenViewModel(),
      child: const MainScreenWidget(),
    );
  }
}