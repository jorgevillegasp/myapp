import 'package:flutter/material.dart';
import 'package:myapp/modules/cart/page/carrito_screen.dart';
import 'package:myapp/modules/cart/services/cart_provider.dart';
import 'package:myapp/modules/product/services/product_provider.dart';
import 'package:provider/provider.dart';

class DettaleScreen extends StatefulWidget {
  const DettaleScreen({Key? key}) : super(key: key);

  @override
  State<DettaleScreen> createState() => _DettaleScreen();
}

class _DettaleScreen extends State<DettaleScreen> {
  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detale Producto"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (cartProvider.carProducts.isEmpty) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 400,
              child: FadeInImage(
                placeholder: const AssetImage("assets/jar-loading.gif"),
                image: NetworkImage(
                    "https://gestion.promo.ec/${productoProvider.producto.imagenes[0]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
            child: Text(
              productoProvider.producto.nombre,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
            child: Text(
              productoProvider.producto.descripcion,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "\$ ${productoProvider.producto.precio}",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text("Agregar al carrito"),
          ],
        ),
        onPressed: () {
          cartProvider.addProductCar(productoProvider.producto);
                final snackBar = SnackBar(
                  content: const Text('Agregado al carrito!'),
                  action: SnackBarAction(
                    label: 'ok!!!',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
