import 'package:flutter/material.dart';
import 'package:flutter_market/configs/constants.dart';
import 'package:flutter_market/domain/repositories/products_repository.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabela = ProductRepository.tabela;
    return Scaffold(
      appBar: AppBar(
        title: Text('Listinha'),
        centerTitle: true,
        leading: Transform.scale(
          scale: 0.75,
          child: CircleAvatar(
            backgroundImage: AssetImage(imageProfile),
          ),
        ),
        actions: [IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        )],
      ),

      body: ListView.separated(
        itemCount: tabela.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text(
            tabela[index].name, 
            style: TextStyle(fontSize: 20),
          ),
          trailing: Text(
            '\$ ${tabela[index].price.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

}