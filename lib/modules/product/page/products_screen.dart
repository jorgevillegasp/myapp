import 'package:flutter/material.dart';
import 'package:myapp/modules/cart/page/carrito_screen.dart';
import 'package:myapp/modules/cart/services/cart_provider.dart';
import 'package:myapp/modules/product/models/producto.dart';
import 'package:myapp/modules/product/services/category_providers.dart';
import 'package:myapp/modules/product/services/product_provider.dart';
import 'package:myapp/modules/product/widget/product_card.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final products = <Producto>[];
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final categoriaProvider = Provider.of<CategoryProvider>(context);
    final carProvider = Provider.of<CartProvider>(context);

    productsProvider.getProductos(categoriaProvider.categoria.idCategoria);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoriaProvider.categoria.nombre),
        actions: [
          IconButton(
            onPressed: () {
              if (carProvider.carProducts.isEmpty) {
                final snackBar = SnackBar(
                  content: const Text('No hay productos en el carrito!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const CarritoScreen()),
                );
              }
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productsProvider.products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: productsProvider.products[index],
          );
        },
      ),
    );
  }
}
