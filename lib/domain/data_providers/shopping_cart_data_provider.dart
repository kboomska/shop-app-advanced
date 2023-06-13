import 'package:flutter/material.dart';

class ShoppingCartItem {
  final int id;
  final String name;
  final String imageUrl;
  final int price;
  final int weight;
  final int quantity;

  ShoppingCartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.weight,
    required this.quantity,
  });

  ShoppingCartItem copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? price,
    int? weight,
    int? quantity,
  }) {
    return ShoppingCartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingCartItem &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.price == price &&
        other.weight == weight &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        price.hashCode ^
        weight.hashCode ^
        quantity.hashCode;
  }
}

class ShoppingCartDataProvider extends ChangeNotifier {
  static final instance = ShoppingCartDataProvider._();
  final _items = <int, ShoppingCartItem>{};

  ShoppingCartDataProvider._();

  Map<int, ShoppingCartItem> get items => Map.unmodifiable(_items);

  void addShoppingCartItem({
    required int id,
    required String name,
    required String imageUrl,
    required int price,
    required int weight,
  }) {
    if (_items.containsKey(id)) {
      increaseItemQuantity(id);
    } else {
      _items.putIfAbsent(
        id,
        () => ShoppingCartItem(
          id: id,
          name: name,
          imageUrl: imageUrl,
          price: price,
          weight: weight,
          quantity: 1,
        ),
      );
      notifyListeners();
    }
  }

  void increaseItemQuantity(int id) {
    _items.update(
      id,
      (existingItem) => existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void decreaseItemQuantity(int id, int quantity) {
    if (_items.containsKey(id)) {
      if (quantity > 1) {
        _items.update(
          id,
          (existingItem) => existingItem.copyWith(
            quantity: existingItem.quantity - 1,
          ),
        );
      } else {
        _items.remove(id);
      }
    }
    notifyListeners();
  }

  void resetShoppingCart() {
    _items.clear();
    notifyListeners();
  }
}
