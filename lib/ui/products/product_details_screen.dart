// lib/ui/details/product_details_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_market/domain/models/product.dart';
import 'package:intl/intl.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product produto;

  const ProductDetailsPage({super.key, required this.produto});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _quantidadeController = TextEditingController();
  double totalPagar = 0;

  void adicionarAoCarrinho() {
    if (_form.currentState!.validate()) {
      // Aqui iria a lógica para adicionar ao carrinho de verdade
      
      // Volta para a tela anterior
      Navigator.pop(context);

      // Mostra uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto adicionado ao carrinho!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Mostra o nome e o preço do produto
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_basket_outlined, size: 50),
                  SizedBox(width: 16),
                  Text(
                    real.format(widget.produto.price),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Mostra o total a pagar, se a quantidade for > 0
            if (totalPagar > 0)
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Total a Pagar: ${real.format(totalPagar)}',
                  style: TextStyle(fontSize: 20, color: Colors.cyan),
                ),
              ),

            // Formulário para digitar a quantidade
            Form(
              key: _form,
              child: TextFormField(
                controller: _quantidadeController,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantidade',
                  suffix: Text('unidades'),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantidade';
                  }
                  if (int.parse(value) <= 0) {
                    return 'A quantidade deve ser maior que zero';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    totalPagar = (value.isEmpty)
                        ? 0
                        : int.parse(value) * widget.produto.price;
                  });
                },
              ),
            ),
            
            // Botão para adicionar ao carrinho
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: adicionarAoCarrinho,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Adicionar ao Carrinho', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}