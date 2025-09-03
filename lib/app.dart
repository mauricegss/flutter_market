import 'package:flutter/material.dart';
import 'package:flutter_market/configs/app_routes.dart';
import 'package:flutter_market/configs/market_theme.dart';
import 'package:flutter_market/domain/repositories/cart_repository.dart';
import 'package:flutter_market/domain/repositories/products_repository.dart';
import 'package:flutter_market/ui/products/products_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductRepository>(create: (_) => ProductRepository()),
        ChangeNotifierProvider<CartRepository>(create: (_) => CartRepository()),
        ChangeNotifierProvider<ProductsViewModel>(
          create: (context) => ProductsViewModel(
            repository: context.read<ProductRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mercadinho',
        debugShowCheckedModeBanner: false,
        theme: MarketTheme.theme, // <-- MUDANÇA AQUI
        initialRoute: AppRoutes.products, // <-- MUDANÇA AQUI
        onGenerateRoute: AppRoutes.generateRoute, // <-- MUDANÇA AQUI
      ),
    );
  }
}