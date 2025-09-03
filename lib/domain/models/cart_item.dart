import 'package:flutter_market/domain/models/product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}