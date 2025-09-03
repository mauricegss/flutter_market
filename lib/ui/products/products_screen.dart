import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_market/configs/app_routes.dart';
import 'package:flutter_market/domain/models/product.dart';
import 'package:flutter_market/domain/repositories/cart_repository.dart';
import 'package:flutter_market/ui/products/products_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  void initState() {
    super.initState();
    // Pede ao ViewModel para carregar os produtos assim que a tela for construída
    // Usamos listen: false aqui porque isso é uma ação, não precisa reconstruir o widget.
    Provider.of<ProductsViewModel>(context, listen: false).loadProducts();
  }

  void _mostrarDetalhes(Product produto) {
    // A navegação agora usa a rota nomeada
    Navigator.pushNamed(
      context,
      AppRoutes.productDetails,
      arguments: produto, // Passando o produto como argumento
    );
  }

  void _showAddProductDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    // Pega o ViewModel uma única vez, pois só vamos chamar uma função
    final viewModel = context.read<ProductsViewModel>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Produto'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nome do Produto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Preço'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um preço.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final newProduct = Product(
                    name: nameController.text,
                    price: double.parse(priceController.text),
                  );
                  // A tela agora só precisa chamar o método do ViewModel!
                  // Não precisa mais de setState.
                  viewModel.addProduct(newProduct);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Assiste ao ViewModel e ao Cart para reconstruir a tela quando eles mudarem
    final viewModel = context.watch<ProductsViewModel>();
    final cart = context.watch<CartRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listinha'),
        leading: Transform.scale(
          scale: 0.75,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images.jpg'),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
              if (cart.totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.totalItems}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      // Mostra um indicador de carregamento enquanto os dados não chegam
      body: !viewModel.isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: viewModel.products.length, // Usa a lista do ViewModel
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey[800]),
              itemBuilder: (context, index) {
                final produto =
                    viewModel.products[index]; // Pega o produto do ViewModel
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.cyan,
                    child: Icon(Icons.shopping_basket_outlined),
                  ),
                  title: Text(
                    produto.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    real.format(produto.price),
                    style: const TextStyle(fontSize: 15),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart_outlined),
                    onPressed: () {
                      context.read<CartRepository>().addToCart(produto, 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('${produto.name} adicionado ao carrinho!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  onTap: () => _mostrarDetalhes(produto),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}