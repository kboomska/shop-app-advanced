import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/domain/api_client/dish_api_client.dart';
import 'package:shop_app/domain/entity/dish.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  final _dishApiClient = DishApiClient();
  final _dishes = <Dish>[];
  final CategoryScreenConfiguration configuration;

  String get title => configuration.name;

  CategoryScreenViewModel(this.configuration);

  List<Dish> get dishes => List.unmodifiable(_dishes);

  Future<void> loadDishes() async {
    final dishesResponse = await _dishApiClient.getDishes();
    _dishes.addAll(dishesResponse.dishes);
    notifyListeners();
  }

  void onDishTap(BuildContext context, int index) {
    final id = _dishes[index].id;
    print('tap on $id');
    // Navigator.of(context).pushNamed(
    //   MainNavigationRouteNames.category,
    //   arguments: id,
    // );
  }
}
