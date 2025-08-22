import 'package:flutter/material.dart';
import 'package:flutter_market/ui/products/products_screen.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercadinho',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
        ),  
        listTileTheme: ListTileThemeData(
          textColor: Colors.white,
        ),
      ),
      home: ProductsScreen(),  
    );
  }
}