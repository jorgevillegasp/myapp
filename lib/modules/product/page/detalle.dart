import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 175,
              child: FadeInImage(
                placeholder: const AssetImage("assets/jar-loading.gif"),
                image: NetworkImage(
                    "https://gestion.promo.ec/${productoProvider.producto.imagenes[0]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(productoProvider.producto.nombre),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(productoProvider.producto.descripcion),
          ),
        ],
      ),
    );
  }
}
