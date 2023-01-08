import 'package:flutter/cupertino.dart';
import 'package:myapp/modules/product/models/producto.dart';

class CartProvider extends ChangeNotifier {

  final List<Producto> _carProducts = [];
  
  addProductCar(Producto p) {
    bool existProduct = false;

    for (var product in _carProducts) {
      if (p.idProducto == product.idProducto) {
        product.cantidad++;
        existProduct = true;
      }
    }
    if (!existProduct) {
      _carProducts.add(p);
    }
    notifyListeners();
  }

  clearCar() {
    _carProducts.clear();
    notifyListeners();
  }

  deleteProduct(Producto product) {
    if (product.cantidad > 1) {
      for (var p in _carProducts) {
        if (p.idProducto == product.idProducto) {
          p.cantidad--;
        }
      }
    } else {
      _carProducts.remove(product);
    }
  }

  List<Producto> get carProducts => _carProducts;
}
