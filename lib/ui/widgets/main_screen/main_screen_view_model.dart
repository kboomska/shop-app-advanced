import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/domain/api_client/api_client_exception.dart';
import 'package:shop_app/domain/services/date_time_service.dart';
import 'package:shop_app/domain/services/category_service.dart';
import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/Library/location_storage.dart';
import 'package:shop_app/domain/entity/category.dart';

class MainScreenViewModel extends ChangeNotifier {
  final _categoryService = CategoryService();
  LocationStorage locationStorage;
  final _categories = <Category>[];
  final _dateTimeService = DateTimeService();

  String? _errorMessage;
  String _date = '';
  String? _location;

  MainScreenViewModel(this.locationStorage);

  String get location => _location ?? 'Определение местоположения...';
  List<Category> get categories => List.unmodifiable(_categories);
  String? get errorMessage => _errorMessage;
  String get date => _date;

  void setup(Locale locale) {
    _date = _dateTimeService.getDate(locale);
    _getAddress(locale);
    notifyListeners();
  }

  Future<void> _getAddress(Locale locale) async {
    if (locationStorage.location.isEmpty) {
      await locationStorage.getAddress(locale);
    }
    _location = locationStorage.location;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    _categories.clear();
    _errorMessage = await fetchCategories();
    notifyListeners();
  }

  Future<String?> fetchCategories() async {
    try {
      final categoriesResponse = await _categoryService.mainScreenCategories();
      _categories.addAll(categoriesResponse.categories);
      notifyListeners();
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Сервер не доступен. Проверьте подключение к сети интернет';
        case ApiClientExceptionType.other:
          return 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (_) {
      return 'Неизвестная ошибка, повторите попытку';
    }
    return null;
  }

  void onCategoryTap(BuildContext context, int index) {
    final configuration = CategoryScreenConfiguration(
      id: _categories[index].id,
      name: _categories[index].name,
    );

    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.category,
      arguments: configuration,
    );
  }
}
