import 'package:flutter/material.dart';
import 'package:myapp/modules/aut/page/login_page.dart';
import 'package:myapp/modules/cart/services/cart_provider.dart';
import 'package:myapp/modules/product/page/home_screen1.dart';
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
    final carProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 600,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FadeInImage(
                          placeholder:
                              const AssetImage("assets/jar-loading.gif"),
                          image: NetworkImage(
                              "https://gestion.promo.ec/${carProvider.carProducts[index].imagenes[0]}"),
                          fit: BoxFit.cover,
                          width: 70,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                carProvider.carProducts[index].nombre,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        carProvider.deleteProduct(
                                            carProvider.carProducts[index]);
                                      });

                                      if (carProvider.carProducts.isEmpty) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                          return const HomeScreen1();
                                        }), (Route<dynamic> route) => false);
                                      }
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text("1"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          carProvider.totalAPagarProducto;
                                          carProvider.addProductCar(
                                              carProvider.carProducts[index]);
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: Text(
                          carProvider.carProducts[index].cantidad.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          "\$ ${double.parse(carProvider.carProducts[index].precio) * carProvider.carProducts[index].cantidad}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: carProvider.carProducts.length,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Valor a pagar : ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      carProvider.totalAPagarProducto.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text("Confirmar compra"),
          ],
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final key = prefs.getString('key') ?? "";

          if (key.isNotEmpty) {
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
                        carProvider.clearCar();
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
          } else {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }), (Route<dynamic> route) => false);
          }
        },
      ),
    );
  }
}
