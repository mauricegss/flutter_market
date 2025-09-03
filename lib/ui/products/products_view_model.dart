import 'package:flutter/material.dart';
import 'package:flutter_market/domain/models/product.dart';
import 'package:flutter_market/domain/repositories/products_repository.dart';

// 1. FAÇA SEU VIEWMODEL "HERDAR" DE CHANGENOTIFIER
class ProductsViewModel extends ChangeNotifier {
  bool isLoaded = false;
  List<Product> products = [];
  final ProductRepository repository;

  ProductsViewModel({required this.repository});

  // Este método será chamado pela tela para carregar os produtos iniciais
  void loadProducts() {
    // Para este exemplo, os dados são locais, então a carga é instantânea
    products = repository.getProducts();
    isLoaded = true;
    
    // 2. AVISE A INTERFACE QUE OS DADOS MUDARAM E ELA PRECISA SE REDESENHAR
    notifyListeners();
  }

  // Este método será chamado pelo diálogo para adicionar um novo produto
  void addProduct(Product product) {
    // Adiciona o produto usando o repositório
    repository.addProduct(product);
    // Atualiza a lista local para refletir a mudança imediatamente
    products = repository.getProducts();

    // 3. AVISE A INTERFACE QUE A LISTA MUDOU
    notifyListeners();
  }
}