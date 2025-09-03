import 'package:flutter_market/domain/models/product.dart';

class ProductRepository {
  // A lista agora é uma variável da instância, não mais "static"
  final List<Product> _products = [
    Product(name: 'Arroz', price: 25.00),
    Product(name: 'Feijão', price: 15.00),
    Product(name: 'Macarrão', price: 10.00),
    Product(name: 'Carne', price: 50.00),
    Product(name: 'Frango', price: 30.00),
    Product(name: 'Leite', price: 8.00),
  ];

  // Método para obter a lista de produtos
  List<Product> getProducts() {
    return _products;
  }

  // Método para adicionar um novo produto à lista
  void addProduct(Product product) {
    _products.add(product);
  }
}