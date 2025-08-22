import 'package:flutter_market/domain/models/product.dart';

class ProductRepository {
  static List<Product> tabela = [
    Product(
      name: 'Arroz',
      price: 25.00,
    ),
    Product(
      name: 'Feijão',
      price: 15.00,
    ),
    Product(
      name: 'Macarrão',
      price: 10.00,
    ),
    Product(
      name: 'Carne',
      price: 50.00,
    ),
    Product(
      name: 'Frango',
      price: 30.00,
    ),
    Product(
      name: 'Leite',
      price: 8.00,
    ),
  ];
}
