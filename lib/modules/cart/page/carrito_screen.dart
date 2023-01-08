import 'package:flutter/material.dart';
import 'package:myapp/modules/product/page/home_screen1.dart';
import 'package:myapp/modules/product/services/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({Key? key}) : super(key: key);

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: FadeInImage(
                      placeholder: const AssetImage("assets/jar-loading.gif"),
                      image: NetworkImage(
                          "https://gestion.promo.ec/${productsProvider.carProducts[index].imagenes[0]}"),
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(productsProvider.carProducts[index].nombre),
                  ),
                  SizedBox(
                    width: 30,
                    child: Text(
                      productsProvider.carProducts[index].cantidad.toString(),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      "\$ ${double.parse(productsProvider.carProducts[index].precio) * productsProvider.carProducts[index].cantidad}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.delete_outline,
                        color: Colors.red, size: 20),
                    onPressed: () {
                      setState(() {
                        productsProvider
                            .deleteProduct(productsProvider.carProducts[index]);
                      });

                      if (productsProvider.carProducts.isEmpty) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen1();
                        }), (Route<dynamic> route) => false);
                      }
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: productsProvider.carProducts.length),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text("Comprar"),
          ],
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final user = prefs.getString('user') ?? "";

          if (user.isNotEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Text(
                    "Compra Exitosa!",
                    style: TextStyle(fontSize: 20),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text("OK"),
                      onPressed: () {
                        productsProvider.clearCar();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen1();
                        }), (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
