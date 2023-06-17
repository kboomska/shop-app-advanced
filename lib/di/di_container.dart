import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/app/shop_app.dart';
import 'package:shop_app/main.dart';

AppFactory makeShopAppFactory() => const _ShopAppFactoryDefault();

class _ShopAppFactoryDefault implements AppFactory {
  final _diContainer = const _DIContainer();

  const _ShopAppFactoryDefault();

  @override
  Widget makeShopApp() => const ShopApp();
}

class _DIContainer {
  const _DIContainer();
}
