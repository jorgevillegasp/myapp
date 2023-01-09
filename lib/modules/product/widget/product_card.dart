import 'package:flutter/material.dart';
import 'package:myapp/modules/cart/services/cart_provider.dart';
import 'package:myapp/modules/product/models/producto.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  Producto product;
  ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 50),
        width: double.infinity,
        //decoration: _cardBorders(),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
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
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                widget.product.precio,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ElevatedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: const [
                    Text("Agregar al carrito"),
                    Icon(Icons.shopping_cart)
                  ],
                ),
              ),
              onPressed: () {
                carProvider.addProductCar(widget.product);
                carProvider.totalAPagarProducto;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 400),
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 135, 193, 207),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Se agrego al carrio"))
                        ],
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
