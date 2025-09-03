import 'package:flutter/material.dart';
import 'package:flutter_market/domain/models/cart_item.dart';
import 'package:flutter_market/domain/models/product.dart';

class CartRepository extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems => _items.fold(0, (total, item) => total + item.quantity);

  void addToCart(Product product, int quantity) {
    try {
      final existingItem = _items.firstWhere(
        (item) => item.product.name == product.name,
      );
      existingItem.quantity += quantity;
    } catch (e) {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }
}