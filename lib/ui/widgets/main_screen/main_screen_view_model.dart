import 'package:flutter/material.dart';

import 'package:shop_app/domain/api_client/category_api_client.dart';
import 'package:shop_app/domain/entity/category.dart';

class MainScreenViewModel extends ChangeNotifier {
  final _categoryApiClient = CategoryApiClient();
  final _categories = <Category>[];

  List<Category> get categories => List.unmodifiable(_categories);

  Future<void> loadCategories() async {
    final categoriesResponse = await _categoryApiClient.getCategories();
    _categories.addAll(categoriesResponse.categories);
    notifyListeners();
  }

  void onCategoryTap() {
    print('tap');
  }
}
