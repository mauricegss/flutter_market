import 'package:flutter/material.dart';
import 'package:flutter_market/domain/models/product.dart';
import 'package:flutter_market/ui/products/product_details_screen.dart';
import 'package:flutter_market/ui/products/products_screen.dart';

class AppRoutes {
  static const String products = '/';
  static const String productDetails = '/product-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case products:
        return MaterialPageRoute(builder: (_) => const ProductsScreen());

      case productDetails:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(produto: product),
        );

      default:
        // Rota de erro caso algo dê errado
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Página não encontrada para a rota: ${settings.name}'),
            ),
          ),
        );
    }
  }
} 