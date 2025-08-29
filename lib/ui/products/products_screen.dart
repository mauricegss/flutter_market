// lib/ui/products/products_screen.dart

import 'package:flutter/material.dart';
// NOVO: Importando o modelo de produto e o formatador de moeda.
import 'package:flutter_market/domain/models/product.dart';
import 'package:flutter_market/domain/repositories/products_repository.dart';
import 'package:intl/intl.dart';
// NOVO: Importaremos a página de detalhes no próximo passo.
import 'package:flutter_market/ui/products/product_details_screen.dart';


// MUDANÇA: Convertemos de StatelessWidget para StatefulWidget
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Puxando a lista de produtos do nosso "repositório"
  final tabela = ProductRepository.tabela;
  
  // NOVO: Lista para guardar os produtos que o usuário selecionar.
  List<Product> selecionadas = [];
  
  // NOVO: Instância do formatador de moeda, igual ao app do professor.
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  
  // NOVO: Função que cria a AppBar dinâmica.
  // Ela verifica se a lista "selecionadas" está vazia e mostra uma AppBar diferente.
  AppBar appBarDinamica() {
    if (selecionadas.isEmpty) {
      // Estado normal: Nenhum item selecionado
      return AppBar(
        title: Text('Listinha'),
        // ADICIONAMOS DE VOLTA O SEU CÓDIGO ORIGINAL AQUI:
        leading: Transform.scale(
          scale: 0.75,
          child: CircleAvatar(
            // Você precisa importar o seu arquivo de constantes para a variável funcionar
            // ou colocar o caminho direto como no exemplo abaixo.
            backgroundImage: AssetImage('assets/images.jpg'), 
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Coloque a ação do seu carrinho aqui
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      );
    } else {
      // Estado de seleção: Itens selecionados
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Limpa a seleção e redesenha a tela
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionados'),
        backgroundColor: Colors.blueGrey.shade800,
      );
    }
  }

  // NOVO: Função para navegar para a tela de detalhes.
  // Iremos criar essa tela no próximo passo.
  mostrarDetalhes(Product produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsPage(produto: produto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MUDANÇA: A AppBar agora é criada pela nossa função dinâmica.
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemCount: tabela.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[800]),
        itemBuilder: (context, index) {
          final produto = tabela[index];
          return ListTile(
            // NOVO: Lógica para mostrar um check se o item estiver selecionado.
            leading: selecionadas.contains(produto)
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : CircleAvatar( // Um ícone padrão para o produto
                    child: Icon(Icons.shopping_basket_outlined), 
                    backgroundColor: Colors.cyan,
                  ),
            title: Text(
              produto.name,
              style: TextStyle(fontSize: 20),
            ),
            trailing: Text(
              // MUDANÇA: Usando o formatador de moeda.
              real.format(produto.price),
              style: TextStyle(fontSize: 15),
            ),
            // NOVO: Propriedades para o visual de seleção.
            selected: selecionadas.contains(produto),
            selectedTileColor: Colors.cyan.withAlpha(55),
            
            // NOVO: Ação de clique longo para selecionar/desselecionar.
            onLongPress: () {
              setState(() {
                if (selecionadas.contains(produto)) {
                  selecionadas.remove(produto);
                } else {
                  selecionadas.add(produto);
                }
              });
            },
            
            // NOVO: Ação de clique normal para ver detalhes.
            onTap: () => mostrarDetalhes(produto),
          );
        },
      ),
      
      // NOVO: O botão flutuante agora só aparece se houver itens selecionados.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.add_shopping_cart),
              label: Text(
                'ADICIONAR AO CARRINHO',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null, // Se a lista de selecionadas for vazia, o botão some.
    );
  }
}