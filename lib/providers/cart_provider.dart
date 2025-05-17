import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(Product product, {Map<String, String>? variants}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id &&
          _areVariantsEqual(item.selectedVariants, variants),
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(
        CartItem(
          product: product,
          quantity: 1,
          selectedVariants: variants,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId, {Map<String, String>? variants}) {
    _items.removeWhere(
      (item) =>
          item.product.id == productId &&
          _areVariantsEqual(item.selectedVariants, variants),
    );
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity,
      {Map<String, String>? variants}) {
    final index = _items.indexWhere(
      (item) =>
          item.product.id == productId &&
          _areVariantsEqual(item.selectedVariants, variants),
    );

    if (index >= 0) {
      if (quantity > 0) {
        _items[index].quantity = quantity;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool _areVariantsEqual(
      Map<String, String>? variants1, Map<String, String>? variants2) {
    if (variants1 == null && variants2 == null) return true;
    if (variants1 == null || variants2 == null) return false;
    if (variants1.length != variants2.length) return false;
    return variants1.entries.every(
      (entry) => variants2[entry.key] == entry.value,
    );
  }
} 