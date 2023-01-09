import 'package:flutter/material.dart';
import 'package:myapp/modules/cart/page/carrito_screen.dart';
import 'package:myapp/modules/cart/services/cart_provider.dart';
import 'package:myapp/modules/product/models/producto.dart';
import 'package:myapp/modules/product/page/detalle_screen.dart';
import 'package:myapp/modules/product/services/category_providers.dart';
import 'package:myapp/modules/product/services/product_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductoScreen extends StatefulWidget {
  const ProductoScreen({Key? key}) : super(key: key);

  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  final products = <Producto>[];
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final categoriaProvider = Provider.of<CategoryProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    productsProvider.getProductos(categoriaProvider.categoria.idCategoria);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categoria"),
        actions: [
          IconButton(
            onPressed: () {
              if (cartProvider.carProducts.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 1500),
                      content: Container(
                        padding: const EdgeInsets.all(16),
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 231, 136, 136),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: const [
                            
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text("No hay productos en el carrito"),
                            ),
                          ],
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriaProvider.categories.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  child: GestureDetector(
                    child: Text(
                      categoriaProvider.categories[index].nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        categoriaProvider.categoria =
                            categoriaProvider.categories[index];
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              categoriaProvider.categoria.nombre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                itemCount: productsProvider.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        productsProvider.producto = productsProvider.products[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const DettaleScreen()),
                        );
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 175,
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage("assets/jar-loading.gif"),
                                image: NetworkImage(
                                    "https://gestion.promo.ec/${productsProvider.products[index].imagenes[0]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productsProvider.products[index].nombre,
                              style: const TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Text(
                            ("\$ ${productsProvider.products[index].precio}"),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
