import 'package:flutter/material.dart';

import 'package:shop_app/domain/data_providers/shopping_cart_data_provider.dart';
import 'package:shop_app/domain/services/date_time_service.dart';

class ShoppingCartScreenViewModel extends ChangeNotifier {
  final _dateTimeService = DateTimeService();
  ShoppingCartDataProvider cartData;
  Map<int, ShoppingCartItem> _items = <int, ShoppingCartItem>{};
  String _date = '';

  ShoppingCartScreenViewModel(this.cartData) {
    _setup();
  }

  Map<int, ShoppingCartItem> get items => Map.unmodifiable(_items);
  String get date => _date;

  void getDate(Locale locale) {
    _date = _dateTimeService.getDate(locale);
    notifyListeners();
  }

  void _setup() {
    cartData.addListener(_updateItems);
  }

  void _updateItems() {
    _items = cartData.items;
    notifyListeners();
  }

  void pay() {
    // cartData.items.clear();
  }
}
