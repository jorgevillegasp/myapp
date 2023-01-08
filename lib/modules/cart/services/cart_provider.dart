import 'package:flutter/cupertino.dart';
import 'package:myapp/modules/product/models/producto.dart';

class CartProvider extends ChangeNotifier {
  final List<Producto> _carProducts = [];

  double _totalAPagarProducto = 0;

  double get totalAPagarProducto => _totalAPagarProducto;
  set totalAPagarProducto(double value) {
    _totalAPagarProducto = value;
    notifyListeners();
  }

  calcularPago(bool aumentar, Producto producto) {
    for (var prod in _carProducts) {
      if (producto.idProducto == prod.idProducto) {
        if (aumentar) {
          _totalAPagarProducto =
              _totalAPagarProducto + double.parse(producto.precio);
        } else {
          _totalAPagarProducto =
              _totalAPagarProducto - double.parse(producto.precio);
        }
        return;
      }
    }
  }

  addProductCar(Producto prod) {
    bool existProduct = false;

    //verifiamos si el carrito de compra esta vacio
    if (_carProducts.isEmpty) {
      _carProducts.add(prod);
      _totalAPagarProducto = 0;
      calcularPago(true, prod);
      return;
    }
    for (var product in _carProducts) {
      //Buscamos si el producto ya se encuentra dentro del carrito
      if (prod.idProducto == product.idProducto) {
        //Aumentamos uno mas
        product.cantidad++;
        existProduct = true;
      }
    }
    //Si no existe el producto se guarda el nuevo producto
    if (!existProduct) {
      _carProducts.add(prod);
    }
    calcularPago(true, prod);
    notifyListeners();
  }

  clearCar() {
    _carProducts.clear();
    notifyListeners();
  }

  deleteProduct(Producto prod) {
    if (prod.cantidad > 1) {
      for (var p in _carProducts) {
        if (p.idProducto == prod.idProducto) {
          p.cantidad--;
        }
      }
    } else {
      _carProducts.remove(prod);
    }
    calcularPago(false, prod);
  }

  List<Producto> get carProducts => _carProducts;
}
