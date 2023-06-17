import 'package:flutter/material.dart';

import 'package:shop_app/di/di_container.dart';

abstract class AppFactory {
  Widget makeShopApp();
}

final shopAppFactory = makeShopAppFactory();

void main() {
  final app = shopAppFactory.makeShopApp();
  runApp(app);
}
