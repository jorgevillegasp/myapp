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
                const snackBar = SnackBar(
                  content: Text('No hay productos en el carrito!'),
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
      body: Column(
        children: [
          const Padding(
            
            padding: EdgeInsets.symmetric(
              vertical: 0,
            ),
            child: Text(
              "Categorias",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const ProductsScreen();
                            },
                          ),
                        );
                      });
                    },
                  ),
                ),
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
                    Column(
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Column(
      //       children: [
      //         Container(
      //           padding: const EdgeInsets.all(10),
      //           height: 200,
      //           width: 180,
      //           decoration: BoxDecoration(
      //               color: Colors.amber,
      //               borderRadius: BorderRadius.circular(15)),
      //           child: SizedBox(
      //             child: FadeInImage(
      //               placeholder: const AssetImage("assets/jar-loading.gif"),
      //               image: NetworkImage(
      //                   "https://gestion.promo.ec/${productsProvider.products[index].imagenes[0]}"),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(
      //             productsProvider.products[index].nombre,
      //             style: const TextStyle(
      //               color: Colors.black45,
      //             ),
      //           ),
      //         ),
      //         Text(
      //           ("\$ ${productsProvider.products[index].precio}"),
      //           style: const TextStyle(
      //             color: Colors.black87,
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
