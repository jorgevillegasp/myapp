import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/modules/product/models/product_response.dart';
import 'package:myapp/modules/product/models/producto.dart';

class ProductProvider extends ChangeNotifier {
  final String _base = 'gestion.promo.ec';
  final String _key = "VHozaS85TU9uUnhTR2FpMWh0eUJCZz09";
  final String _value =
      "gAAAAABgAGpunQZzKslbNqIL71S6nhjanaqWYmni6w7Bv_i0nc49t4WyDc3X6fPWVYzx2Lg_3b8PabFJ5RUF2rS43OGWXQ-Yuw==";
  final String _idSucursal = "20";
  final String _idSubcategoria = '0';
  final String _offSet = '0';
  final String _limit = '10';


  List<Producto> products = [];

  getProductos(int id) async {
    var url = Uri.https(
      _base,
      '/promo/productos/ws/categoria-listar-productos/',
      {
        _key.toString(): _value,
        'id_sucursal': _idSucursal,
        'id_categoria': id.toString(),
        'id_subcategoria': _idSubcategoria,
        'offset': _offSet,
        'limit': _limit,
      },
    );
    final response = await http.get(url);
    final productResponse = ProductResponsive.fromJson(response.body);
    products = productResponse.productos;
    notifyListeners();
  }
}
