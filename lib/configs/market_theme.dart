import 'package:flutter/material.dart';

class MarketTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
        seedColor: Colors.cyan,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      ),
    );
  }
}