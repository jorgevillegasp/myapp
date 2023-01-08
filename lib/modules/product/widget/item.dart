import 'package:flutter/material.dart';
import 'package:myapp/modules/cart/services/cart_provider.dart';
import 'package:myapp/modules/product/models/producto.dart';
import 'package:myapp/modules/product/services/product_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Item extends StatefulWidget {
  Producto product;

  Item({super.key, required this.product});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        Container(
          height: 180,
          width: 160,
          padding:const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: FadeInImage(
              placeholder: const AssetImage("assets/jar-loading.gif"),
              image: NetworkImage(
                  "https://gestion.promo.ec/${widget.product.imagenes[0]}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.product.nombre,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Text(
            widget.product.precio,
          ),
        ),
        ElevatedButton(
          child: Image.asset(
            'assets/compra.png',
            width: 33,
          ),
          onPressed: () {
            carProvider.addProductCar(widget.product);
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
        //details_product(),
      ],
    );
  }
}
