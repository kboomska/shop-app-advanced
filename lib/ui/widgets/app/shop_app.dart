import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/home_screen/home_screen_widget.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      home: HomeScreenWidget(),
    );
  }
}
