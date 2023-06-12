import 'package:flutter/material.dart';

import 'package:shop_app/domain/data_providers/shopping_cart_data_provider.dart';
import 'package:shop_app/domain/services/date_time_service.dart';

class ShoppingCartScreenViewModel extends ChangeNotifier {
  final _dateTimeService = DateTimeService();
  ShoppingCartDataProvider cartData;
  List<ShoppingCartItem> _items = <ShoppingCartItem>[];
  String _date = '';
  int _total = 0;

  ShoppingCartScreenViewModel(this.cartData) {
    _setup();
  }

  List<ShoppingCartItem> get items => List.unmodifiable(_items);
  String get total => _total == 0 ? '' : ' $_total ₽';
  String get date => _date;

  void getDate(Locale locale) {
    _date = _dateTimeService.getDate(locale);
    notifyListeners();
  }

  void _setup() {
    _updateItems();
    cartData.addListener(_updateItems);
  }

  void _updateItems() {
    _items = cartData.items.values.toList();
    _totalAmount();
    notifyListeners();
  }

  void onIncreaseQuantity(int id) {
    cartData.increaseItemQuantity(id);
  }

  void onDecreaseQuantity(int id) {
    final item = _items.firstWhere((element) => element.id == id);
    if (item.quantity == 1) _items.remove(item);
    cartData.decreaseItemQuantity(id, item.quantity);
  }

  void _totalAmount() {
    int total = 0;

    for (var value in _items) {
      total += value.price * value.quantity;
    }
    _total = total;
  }

  void pay() {
    // cartData.items.clear();
  }

  @override
  void dispose() {
    cartData.removeListener(_updateItems);
    super.dispose();
  }
}
