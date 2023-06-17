import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:shop_app/domain/data_providers/shopping_cart_data_provider.dart';
import 'package:shop_app/domain/services/date_time_service.dart';
import 'package:shop_app/domain/services/location_service.dart';

class ShoppingCartScreenViewModel extends ChangeNotifier {
  final _dateTimeService = DateTimeService();
  LocationService locationService;
  ShoppingCartDataProvider cartData;
  List<ShoppingCartItem> _items = <ShoppingCartItem>[];
  String _date = '';
  int _total = 0;
  late NumberFormat _formatter;
  String? _location;

  ShoppingCartScreenViewModel(
    this.cartData,
    this.locationService,
  ) {
    _setupData();
  }

  String get location => _location ?? 'Определение местоположения...';
  List<ShoppingCartItem> get items => List.unmodifiable(_items);
  String get total => _total == 0 ? '' : 'Оплатить ${_stringTotal(_total)} ₽';
  String get date => _date;

  void setup(Locale locale) {
    _date = _dateTimeService.getDate(locale);
    _formatter = NumberFormat.decimalPattern(locale.toLanguageTag());
    _getAddress(locale);
    notifyListeners();
  }

  Future<void> _getAddress(Locale locale) async {
    if (locationService.location.isEmpty) {
      await locationService.getAddress(locale);
    }
    _location = locationService.location;
    notifyListeners();
  }

  void _setupData() {
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

  String _stringTotal(int total) {
    return _formatter.format(total);
  }

  void pay() {
    cartData.resetShoppingCart();
  }

  @override
  void dispose() {
    cartData.removeListener(_updateItems);
    super.dispose();
  }
}
