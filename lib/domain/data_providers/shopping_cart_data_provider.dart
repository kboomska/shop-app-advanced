import 'package:flutter/material.dart';

class ShoppingCartItem {
  final String id;
  final String name;
  final int price;
  final int weight;
  final int quantity;

  ShoppingCartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.weight,
    required this.quantity,
  });
}

class ShoppingCartDataProvider extends ChangeNotifier {
  static final instance = ShoppingCartDataProvider._();
  final _items = <int, ShoppingCartItem>{};

  ShoppingCartDataProvider._();

  Map<int, ShoppingCartItem> get items => Map.unmodifiable(_items);

  void addShoppingCartItem({
    required productId,
    required name,
    required price,
    required weight,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => ShoppingCartItem(
            id: existingItem.id,
            name: existingItem.name,
            price: existingItem.price,
            weight: existingItem.weight,
            quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => ShoppingCartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
          weight: weight,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
