import 'package:sandwich_shop/models/sandwich.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({
    required this.sandwich,
    this.quantity = 1,
  });
}

class Cart {
  final List<CartItem> _items = [];
  final double Function({required int quantity, required bool isFootlong}) calculatePrice;

  Cart(this.calculatePrice);

  void add(Sandwich sandwich, {int quantity = 1}) {
    final existingItem = _items.firstWhere(
      (item) =>
          item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType,
      orElse: () => CartItem(sandwich: sandwich, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity += quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void remove(Sandwich sandwich, {int quantity = 1}) {
    final existingItem = _items.firstWhere(
      (item) =>
          item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType,
      orElse: () => CartItem(sandwich: sandwich, quantity: 0),
    );

    if (existingItem.quantity > quantity) {
      existingItem.quantity -= quantity;
    } else {
      _items.remove(existingItem);
    }
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += calculatePrice(
        quantity: item.quantity,
        isFootlong: item.sandwich.isFootlong,
      );
    }
    return total;
  }

  List<CartItem> get items => List.unmodifiable(_items);
}