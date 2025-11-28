import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartItem {
  final String itemType;
  final BreadType breadType;
  int quantity;

  CartItem({
    required this.itemType,
    required this.breadType,
    this.quantity = 1,
  });
}

class Cart {
  final List<CartItem> _items = [];
  final PricingRepository _pricingRepository;

  Cart(this._pricingRepository);

  void addItem(String itemType, BreadType breadType) {
    final existingItem = _items.firstWhere(
      (item) => item.itemType == itemType && item.breadType == breadType,
      orElse: () => CartItem(itemType: itemType, breadType: breadType),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      _items.add(existingItem);
    }
  }

  void removeItem(String itemType, BreadType breadType) {
    final existingItem = _items.firstWhere(
      (item) => item.itemType == itemType && item.breadType == breadType,
      orElse: () => CartItem(itemType: itemType, breadType: breadType),
    );

    if (existingItem.quantity > 1) {
      existingItem.quantity--;
    } else {
      _items.remove(existingItem);
    }
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += _pricingRepository.calculatePrice(
        quantity: item.quantity,
        isFootlong: item.itemType == 'footlong',
      );
    }
    return total;
  }

  List<CartItem> get items => List.unmodifiable(_items);
}