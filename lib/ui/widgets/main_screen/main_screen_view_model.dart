import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:shop_app/domain/api_client/category_api_client.dart';
import 'package:shop_app/Library/localization_storage.dart';
import 'package:shop_app/domain/entity/category.dart';

class MainScreenViewModel extends ChangeNotifier {
  final _categoryApiClient = CategoryApiClient();
  final _categories = <Category>[];
  final _localeStorage = LocalizationStorage();
  late DateFormat _dateFormat;
  late DateFormat _yearFormat;

  String _date = '';

  List<Category> get categories => List.unmodifiable(_categories);
  String get date => _date;

  void setupLocale(Locale locale) {
    if (!_localeStorage.isLocaleUpdated(locale)) return;

    _dateFormat = DateFormat.MMMMd(_localeStorage.localeTag);
    _yearFormat = DateFormat.y(_localeStorage.localeTag);

    _date =
        '${_dateFormat.format(DateTime.now())}, ${_yearFormat.format(DateTime.now())}';
    notifyListeners();
  }

  Future<void> loadCategories() async {
    final categoriesResponse = await _categoryApiClient.getCategories();
    _categories.addAll(categoriesResponse.categories);
    notifyListeners();
  }

  void onCategoryTap() {
    print('tap');
  }
}
