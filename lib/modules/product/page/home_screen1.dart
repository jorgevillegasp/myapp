import 'package:flutter/material.dart';
import 'package:myapp/modules/product/models/category.dart';
import 'package:myapp/modules/product/page/products_screen.dart';
import 'package:myapp/modules/product/services/category_providers.dart';
import 'package:myapp/modules/product/services/product_service.dart';
import 'package:provider/provider.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: categoryProvider.categories.length,
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
                  categoryProvider.categories[index].nombre,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  categoryProvider.categoria = categoryProvider.categories[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductsScreen();
                      },
                    ),
                  );
                },
              ),
            );
          }
          ),
    );
  }
}