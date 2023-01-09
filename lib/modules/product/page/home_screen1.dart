import 'package:flutter/material.dart';
import 'package:myapp/modules/product/page/products_screen.dart';
import 'package:myapp/modules/product/services/category_providers.dart';
import 'package:provider/provider.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoryProvider>(context);
    categoriaProvider.getCategories();
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Text(
                  "My Shop",
                  style: TextStyle(
                    color: Color.fromARGB(255, 59, 50, 92),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Text(
                  "Categorias",
                  style: TextStyle(
                    color: Color.fromARGB(255, 116, 116, 116),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 600,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: categoriaProvider.categories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                      color: const Color.fromARGB(255, 135, 193, 207),
                    ),
                    child: ListTile(
                      title: Text(
                        categoriaProvider.categories[index].nombre,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        categoriaProvider.categoria =
                            categoriaProvider.categories[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const ProductoScreen();
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
